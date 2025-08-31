void foo(int *A, int *B, int n, int mode) {
    for (int i = 0; i < n; i++) {
        switch (mode) {
            case 0: A[i] = B[i] + 1; break;
            case 1: A[i] = B[i] - 1; break;
            case 2: A[i] = B[i] * 2; break;
        }
    }
}
