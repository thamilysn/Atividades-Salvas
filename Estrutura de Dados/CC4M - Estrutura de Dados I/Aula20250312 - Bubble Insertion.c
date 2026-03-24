#include <stdio.h>
void ImprimeVetor(int *x, int n){
    printf("\nVetor [%d]: ", n);
    for(int i=0; i<n; i++){
        printf("| %d ", x[i]);
    }
    printf("| ");
}

void bubbleSort(int *v, int n){
    int i, continua, aux;
    do{
        continua = 0;
        for(i=0; i<n-1;i++){
            if(v[i]>v[i+1]){
                aux = v[i];
                v[i] = v[i+1];
                v[i+1] = aux;
                continua = 1;
            }
        }
        ImprimeVetor(v, 10);
    }while(continua);
}
void bubbleSort2(int *v, int n){
    int i, continua, aux, fim = n;
    do{
        continua = 0;
        for(i=0; i<fim-1;i++){
            if(v[i]>v[i+1]){
                aux = v[i];
                v[i] = v[i+1];
                v[i+1] = aux;
                continua = 1;
            }
        }
        fim--;
    }while(continua);
}

void insertionSort(int *v, int n){
    int i, j, aux;
    for(i=1; i<n; i++){
        aux = v[i];
        for(j = i; ((j>0) && (aux<v[j-i]));j--){
            v[j] = v[j-1];
        }
        v[j] = aux;
        //ImprimeVetor(v, n);
    }
}

int main()
{
    int vet[10] = {6,75,1,14,24,18,3,7,50,10};
    ImprimeVetor(vet, 10);
    insertionSort(vet, 10);
    ImprimeVetor(vet, 10);
    
    
    return 0;
}
