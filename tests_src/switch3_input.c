void doSomethingGlobal() {}

void foo(int *A, int n, int mode) {
    for (int i = 0; i < n; i++) {
        switch (mode) {
            case 0: A[i] += 1; break;
            case 1: A[i] *= 2; break;
            default: doSomethingGlobal(); // побочный эффект
        }
    }
}
