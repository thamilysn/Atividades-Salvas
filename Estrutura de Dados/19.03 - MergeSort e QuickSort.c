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
#include <stdlib.h>
#include <math.h>

void ImprimeVetor(int *v, int n){
    printf("\nVetor: |");
    for(int i=0; i < n; i++){
        printf("%d |", v[i]);
    }
}

void merge(int *v, int inicio, int meio, int fim){
    int *temp, i, j, k, tamanho, p1, p2, fim1 = 0, fim2 = 0;
    tamanho = fim - inicio + 1;
    p1 = inicio;
    p2 = meio + 1;
    temp = (int*)malloc(tamanho * sizeof(int));
    
    if(temp!=NULL){
        for(i = 0; i < tamanho; i++){
            if(!fim1 && !fim2){ 
                if(v[p1] < v[p2]){
                    temp[i] = v[p1];
                    p1++;
                    if(p1 > meio) fim1 = 1;
                    
                }else{
                    temp[i] = v[p2++];
                }
            
            }else{
                if(!fim1){
                    temp[i] = v[p1++]; 
                }
                
                else{temp[i] = v[p2++];}
            }
        }
        for(j =0, k = inicio; j < tamanho; j++, k++){
            v[k] = temp[j];
        }
    }
    free(temp);
}

void mergeSort(int *v, int inicio, int fim){
    int meio;
    
    if(inicio < fim){
        meio = floor((inicio + fim) / 2);
        mergeSort(v, inicio, meio);
        mergeSort(v, meio + 1, fim);
        merge(v, inicio, meio, fim);
    }
    
}

int main()
{
    int vet[10] = {6,75,1,14,24,18,3,7,50,10};
    ImprimeVetor(vet, 10);
    mergeSort(vet, 0, 9);
    ImprimeVetor(vet, 10);
    return 0;
}

//QuickSort
