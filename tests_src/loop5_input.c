void qux(float *A, float *B, int n, int flag) {
    for (int i = 0; i < n; i++) {
        if (flag)
            A[i] = B[i] + 1.0f;
        else
            A[i] = B[i] - 1.0f;
    }
}
