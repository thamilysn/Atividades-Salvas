//Conceito de malloc e free
#include <stdio.h>

int main() {
    int *p;
    int i, n = 100;

    p = (int *) malloc(n * sizeof(int));

    if (p == NULL) {
        printf("Problema de alocação de memória");
        return 1;
    }

    for (i = 0; i < n; i++) {
        scanf("%d", &p[i]);
    }

    free(p);
    return 0;
}

//MergeSort
//QuickSort
