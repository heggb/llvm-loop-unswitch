#!/usr/bin/env python3
import argparse, subprocess, sys, time
from pathlib import Path

# --- Автодетект путей относительно scripts/ ---
SCRIPT_DIR  = Path(__file__).resolve().parent
PROJECT_DIR = SCRIPT_DIR.parent                 # llvm-loop-unswitch/
LLVM_ROOT   = PROJECT_DIR.parent                # .../llvm-project/

SRC_DIR     = PROJECT_DIR / "tests_src"         # .c / .cpp входы
IR_DIR      = PROJECT_DIR / "build" / "ir"      # IR после clang
IR_OPT_DIR  = PROJECT_DIR / "build" / "ir_opt"  # IR после opt
RESULTS_DIR = PROJECT_DIR / "results"           # Эталоны
PASSES_DIR  = PROJECT_DIR / "build"             # Где лежат *.so

# --- Инструменты LLVM ---
CLANG   = LLVM_ROOT / "build" / "bin" / "clang-22"
CLANGXX = LLVM_ROOT / "build" / "bin" / "clang++-22"
OPT     = LLVM_ROOT / "build" / "bin" / "opt"

# --- Конфиг проходов (добавлен LoopUnswitch) ---
PASS_CONFIG = {
    "LoopUnswitch": {
        "plugin": "libLoopUnswitch.so",
        "mode": "new",
        "pipeline": (
            "function("
            "mem2reg,"
            "loop-simplify,"
            "lcssa,"
            "require<memoryssa>,"
            "loop-mssa(licm),"
            "loop(loop-unswitch-pass<threshold=0>),"
            "simplifycfg,"
            "lcssa,"
            "loop-simplify,"
            "require<memoryssa>,"
            "loop-mssa(licm),"
            "simplifycfg)"
        ),
    },
}

def cprint(msg):  # короткий принтер без раскраски
    print(msg)

def ensure_dirs():
    IR_DIR.mkdir(parents=True, exist_ok=True)
    IR_OPT_DIR.mkdir(parents=True, exist_ok=True)
    RESULTS_DIR.mkdir(parents=True, exist_ok=True)

def _pick_compiler(src: Path) -> Path:
    # Для .cpp используем clang++-22, если есть; иначе clang-22
    if src.suffix == ".cpp" and CLANGXX.exists():
        return CLANGXX
    return CLANG

def _resolve_src(filename: str) -> Path:
    """Разрешить путь к исходнику:
       1) точное совпадение
       2) если .c не найден, но есть одноимённый .cpp — берём .cpp
       3) если .cpp не найден, но есть одноимённый .c — берём .c
    """
    cand = (SRC_DIR / filename).resolve()
    if cand.exists():
        return cand

    stem = Path(filename).stem
    # если просили .c — попробуем .cpp
    cpp = (SRC_DIR / f"{stem}.cpp").resolve()
    c   = (SRC_DIR / f"{stem}.c").resolve()

    if Path(filename).suffix == ".c" and cpp.exists():
        return cpp
    if Path(filename).suffix == ".cpp" and c.exists():
        return c

    # если расширение отсутствует/левое — попробуем оба
    if cpp.exists():
        return cpp
    if c.exists():
        return c

    # не нашли
    return cand  # вернём «как есть» — выше по стэку выведем ошибку

def _output_stem_from_input_stem(input_stem: str) -> str:
    """Имя эталона: *_output.ll вместо *_input.ll.
       Если в стеме нет '_input', добавим суффикс '_output'.
    """
    if input_stem.endswith("_input"):
        return input_stem[:-6] + "_output"  # убрать '_input', добавить '_output'
    return input_stem + "_output"

# ----------------- ЭТАПЫ КОМПИЛЯЦИИ/ОПТИМИЗАЦИИ -----------------

def compile_to_ir(src_file: Path) -> Path:
    """Компилирует C/C++ -> LLVM IR (.ll) в build/ir/<name>.ll"""
    ensure_dirs()
    compiler = _pick_compiler(src_file)
    out_ll = IR_DIR / (src_file.stem + ".ll")
    cmd = [
        str(compiler),
        "-O0",
        "-S",
        "-emit-llvm",
        "-Xclang", "-disable-O0-optnone",
        "-fno-discard-value-names",
        str(src_file),
        "-o", str(out_ll),
    ]
    proc = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    if proc.returncode != 0 or not out_ll.exists():
        raise RuntimeError(f"[clang] failed for {src_file.name}:\n{proc.stderr}")
    return out_ll

def run_opt_to_file(ir_in: Path, pass_name: str, ir_out: Path) -> float:
    """Гоняет opt и сохраняет оптимизированный IR в ir_out (.ll). Возвращает время (мс)."""
    cfg = PASS_CONFIG.get(pass_name)
    if not cfg:
        raise KeyError(f"Unknown pass '{pass_name}'. Known: {', '.join(PASS_CONFIG.keys())}")

    plugin_path = PASSES_DIR / cfg["plugin"]
    if not plugin_path.exists():
        raise FileNotFoundError(f"Plugin not found: {plugin_path}")

    pipeline = cfg["pipeline"]
    if cfg.get("mode", "new") == "new":
        cmd = [
            str(OPT),
            f"-load-pass-plugin={plugin_path}",
            f"-passes={pipeline}",
            "-S", str(ir_in),
            "-o", str(ir_out),
        ]
    else:
        cmd = [
            str(OPT),
            f"-load={plugin_path}",
            f"-{pipeline}",
            "-S", str(ir_in),
            "-o", str(ir_out),
        ]

    start = time.time()
    proc = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    elapsed_ms = (time.time() - start) * 1000.0
    if proc.returncode != 0 or not ir_out.exists():
        raise RuntimeError(
            f"[opt] failed for {ir_in.name} with {pass_name}:\n{proc.stderr}"
        )
    return elapsed_ms


def baseline_path(pass_name: str, src_file: Path) -> Path:
    """Путь к эталону .ll: results/<pass>/<stem_output>.ll"""
    p = RESULTS_DIR / pass_name
    p.mkdir(parents=True, exist_ok=True)
    stem_out = _output_stem_from_input_stem(src_file.stem)
    return p / (stem_out + ".ll")

def compare_text(actual: str, expected: str):
    """Строгое построчное сравнение с сообщением о первом расхождении."""
    a = [l.rstrip() for l in actual.splitlines()]
    e = [l.rstrip() for l in expected.splitlines()]
    for i, exp in enumerate(e):
        if i >= len(a):
            return False, f"Mismatch at line {i+1}\nExpected: {exp}\nGot     : <no line>\n"
        if a[i] != exp:
            return False, f"Mismatch at line {i+1}\nExpected: {exp}\nGot     : {a[i]}\n"
    if len(a) > len(e):
        return False, f"Extra output starting at line {len(e)+1}: {a[len(e)]}\n"
    return True, ""


def run_single(pass_name: str, filename: str, keep: bool = False) -> bool:
    src = _resolve_src(filename)
    if not src.exists():
        cprint(f"✖ Source not found: {src}")
        return False

    # 1) C/C++ -> IR
    try:
        ir_in = compile_to_ir(src)
    except Exception as e:
        cprint(f"✖ clang error: {e}")
        return False

    # 2) IR → OPT-IR
    ir_opt = IR_OPT_DIR / (src.stem + ".opt.ll")
    try:
        elapsed_ms = run_opt_to_file(ir_in, pass_name, ir_opt)
    except Exception as e:
        cprint(f"✖ opt error: {e}")
        if not keep:
            ir_in.unlink(missing_ok=True)
            ir_opt.unlink(missing_ok=True)
        return False

    # 3) Сравнение с эталоном (по *_output.ll)
    exp = baseline_path(pass_name, src)
    if not exp.exists():
        cprint(f"✖ Baseline not found: {exp}")
        cprint("Tip: run with --update to create baseline from optimized IR.")
        if not keep:
            ir_in.unlink(missing_ok=True)
            ir_opt.unlink(missing_ok=True)
        return False

    ok, msg = compare_text(
        ir_opt.read_text(encoding="utf-8").strip(),
        exp.read_text(encoding="utf-8").strip(),
    )
    name = f"{pass_name}:{src.name}"
    if ok:
        cprint(f"{name}: OK ({elapsed_ms:.1f} ms)")
    else:
        cprint(f"\n{name}: MISMATCH\n{msg}")

    # 4) Уборка
    if not keep:
        ir_in.unlink(missing_ok=True)
        ir_opt.unlink(missing_ok=True)
    return ok

def discover_tests(only_pass: str | None):
    items = []
    for ext in ("*.c", "*.cpp"):
        for src in sorted(SRC_DIR.glob(ext)):
            if only_pass:
                items.append((only_pass, src.name))
            else:
                for p in PASS_CONFIG.keys():
                    items.append((p, src.name))
    return items

def main():
    ap = argparse.ArgumentParser(description="LLVM pass tester: compares optimized IR (.ll) with baselines")
    ap.add_argument("pass_name", nargs="?", help=f"One of: {', '.join(PASS_CONFIG.keys())}")
    ap.add_argument("src_file",  nargs="?", help="Single test file from tests_src (e.g. switch6_input.c)")
    ap.add_argument("--update", action="store_true",
                    help="Write optimized IR (.ll) as baseline to results/<pass>/<stem_output>.ll")
    ap.add_argument("--keep", action="store_true",
                    help="Keep temporary IR files in build/ir*")
    args = ap.parse_args()

    if args.pass_name and args.src_file:
        scope = [(args.pass_name, args.src_file)]
    elif args.pass_name:
        scope = discover_tests(args.pass_name)
    else:
        scope = discover_tests(None)

    if not scope:
        cprint("No tests discovered.")
        sys.exit(2)

    total = passed = 0
    for p, fname in scope:
        total += 1
        if args.update:
            try:
                src_path = _resolve_src(fname)
                if not src_path.exists():
                    raise FileNotFoundError(f"Source not found: {src_path}")
                ir_in = compile_to_ir(src_path)
                ir_opt = IR_OPT_DIR / (src_path.stem + ".opt.ll")
                run_opt_to_file(ir_in, p, ir_opt)
                out_path = baseline_path(p, src_path)  # *_output.ll
                out_path.parent.mkdir(parents=True, exist_ok=True)
                out_path.write_text(ir_opt.read_text(encoding="utf-8").strip() + "\n", encoding="utf-8")
                cprint(f"Updated baseline: {out_path}")
                passed += 1
            except Exception as e:
                cprint(f"Failed to update {p}:{fname}: {e}")
            finally:
                if not args.keep:
                    (IR_DIR / (Path(fname).stem + ".ll")).unlink(missing_ok=True)
                    (IR_OPT_DIR / (Path(fname).stem + ".opt.ll")).unlink(missing_ok=True)
        else:
            if run_single(p, fname, keep=args.keep):
                passed += 1

    print()
    if passed == total:
        cprint(f"✅ All {total} test(s) passed")
        sys.exit(0)
    else:
        cprint(f"❌ {total - passed} of {total} test(s) failed")
        sys.exit(1)

if __name__ == "__main__":
    main()
