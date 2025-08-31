void foo(int *a, int n, int flag) {
    for (int i = 0; i < n; ++i) {
        if (flag) {
            a[i] = a[i] * 2;
        } else {
            a[i] = a[i] + 1;
        }
    }
}
