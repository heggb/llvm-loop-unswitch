# MCST llvm-loop-pass

Этот репозиторий содержит реализацию и тесты loop unswitch. Проект ориентирован на исследование промежуточного представления (LLVM IR), а также написание и проверку собственных анализирующих проходов компилятора.

## Состав проекта

- src/ — основной исходный код, содержащий реализации LLVM-пассов и вспомогательные модули.
- include/ — заголовочные файлы для подключения собственных компонентов.
- tests_src/ — исходники тестов, демонстрирующие применение и корректность работы написанных пассов.
- scripts/ — вспомогательные скрипты для сборки, запуска и анализа результатов.
- results/ — директория для сохранения результатов выполнения тестов и оптимизаций.
- build/ — каталог для сборки.
- build/ir — каталог для временного хранения "первичных" IR.
- build/ir_opt — каталог для временного хранения IR после оптимизации.

## Требования

Для работы с проектом необходимы:

- [`clang`](https://clang.llvm.org/) — компилятор Clang
- [`opt`](https://llvm.org/docs/CommandGuide/opt.html) — инструмент оптимизации из набора LLVM
- [`cmake`](https://cmake.org/)) — система сборки
- [`ninja`](https://ninja-build.org/) или [`make`] — генератор сборки

## Проходы

- MyPass - взят из примера (https://github.com/LevchenkoDmitriy/llvm-basic-pass), реализует вывод имён функций и количтество их аргументов.
- RPOPass - меняет для каждой функции наименования у базовых блоков, выводит циклы в CFG графе (без учёта доминирования) и, соотвтественно, сами блоки в RPO нумераци.
- InstSearchPass — выводит для каждой функции список всех её инструкции с количеством использований в алфавитном порядке.

## Быстрый старт

1. **Склонируйте репозиторий:**

```bash
cd llvm-project
git https://github.com/heggb/llvm-loop-unswitch.git
```

2. **Создайте переменную окружения:**

```bash
export LLVM_DIR=<path to llvm-project>
```

3. **Сгенерируйте файл сборки и соберите:**

```bash
cd llvm-test-passes/build
cmake -DLT_LLVM_INSTALL_DIR=$LLVM_DIR .
make
```

4. **Перейдите в llvm-project и получите LLVM IR (например, для switch6_input.c):**

```bash
cd llvm-project
./build/bin/clang-22 -O0 -S -emit-llvm -Xclang -disable-O0-optnone -fno-discard-value-names ./llvm-loop-unswitch/tests_src/switch6_input.c -o switch6_input.ll
```


5. **Запустите проход (например, для switch6_input.c):**

```bash
cd llvm-project
./build/bin/opt \
  -load-pass-plugin ./llvm-loop-unswitch/build/libLoopUnswitch.so \
  -passes='function(
    mem2reg,
    loop-simplify,
    lcssa,
    require<memoryssa>,
    loop-mssa(licm),
    loop(loop-unswitch-pass<threshold=0>),
    simplifycfg,
    lcssa,
    loop-simplify,
    require<memoryssa>,
    loop-mssa(licm),
    simplifycfg
  )' \
  -S switch6_input.ll \
  -o switch6_output.ll
```

## Тестирование

1. **Перейдите в каталог со скриптами:**

```bash
cd llvm-loop-unswitch/scripts
```

2. **Запустите скрипт теста нужного прохода для нужного файла (например, для switch6_input.c):**

```bash
python3 test_passes.py LoopUnswitch switch6_input.c
```

3. **Для теста всех проходов на всех файлах запустите скрипт без дополнительных параметров:**

```bash
python3 test_passes.py LoopUnswitch
```

