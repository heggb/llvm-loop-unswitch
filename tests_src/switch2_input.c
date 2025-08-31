void foo(int *A, int n, int mode) {
    for (int i = 0; i < n; i++) {
        switch (mode) {
            case 0: 
                if (A[i] == 0) break;  // выходит только из цикла
                A[i] += 1; 
                break;
            case 1: 
                return;                // досрочный выход из функции
            case 2: 
                A[i] *= 2; 
                break;
        }
    }
}
