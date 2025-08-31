void foo(int *A, int n, int flag1, int flag2) {
    for (int i = 0; i < n; i++) {
        if (flag1)
            A[i] += 1;
        if (flag2)
            A[i] *= 2;
    }
}
