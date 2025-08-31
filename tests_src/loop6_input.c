void qux(float *A, float *B, int n, int flag1, int flag2, int flag3) {
    for (int i = 0; i < n; i++) {
        if (flag1)
            A[i] = B[i] + 1.0f;
        if (flag2)
            A[i] = B[i] - 1.0f;
        if (flag3) {
            A[i] *= 2.0f;
            B[i] /= 2.0f;
        }
    }
}
