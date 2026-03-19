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
#include <stdio.h>

void mergeSort(int *V, int inicio, int fim){
    int meio;
    if(inicio < fim){
        meio = floor((inicio+fim) / 2);
        
        mergeSort (V, inicio, meio);
        mergeSort (V, meio + 1, fim);
        mergeSort (V, inicio, meio, fim);
    }
}

void merge(int *V, int inicio, int meio, int fim){
    int i = inicio;
    int j = meio + 1;
    int k = 0;

    int *aux = (int*) malloc((fim - inicio + 1) * sizeof(int));

    while (i <= meio && j <= fim){
        if (V[i] < V[j])
            aux[k++] = V[i++];
        else
            aux[k++] = V[j++];
    }

    while (i <= meio){
        aux[k++] = V[i++];
    }

    while (j <= fim){
        aux[k++] = V[j++];
    }

    for (i = inicio, k = 0; i <= fim; i++, k++){
        V[i] = aux[k];
    }

    free(aux);
}

int main()
{
    int V[10] = {12, 15, 43, 10, 28, 45, 19, 4, 16, 13};
    mergeSort(V, 10);
    for(int i = 0; i < 10; i++)
    printf("%d|", V[i]);

    return 0;
}

//QuickSort
