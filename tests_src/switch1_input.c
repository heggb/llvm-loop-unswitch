void foo(int *a, int n, int flag) {
    for (int i = 0; i < n; ++i) {
        switch (flag) {
            case 0: a[i] += 1; break;
            case 1: a[i] -= 2; break;
            case 2: a[i] *= 3; break;
            default: a[i] /= 4; break;
        }
    }
}
