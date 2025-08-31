void foo(int *A, int n, int flag) {
    for (int i = 0; i < n; i++) {
        if (flag) {
            if (A[i] == 0) break;   // ранний выход
            A[i] += 1;
        } else {
            A[i] -= 1;
        }
    }
}
