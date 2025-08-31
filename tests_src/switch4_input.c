void foo(int *A, int *B, int n, int flag1, int flag2) {
    for (int i = 0; i < n; i++) {
        switch (flag1) {
            case 0: A[i] += 1; break;
            case 1: A[i] -= 1; break;
        }
        switch (flag2) {
            case 0: B[i] += 2; break;
            case 1: B[i] -= 2; break;
        }
    }
}
