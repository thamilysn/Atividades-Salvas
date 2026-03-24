#include <stdio.h>
void ImprimeVetor(int *x, int n){
    printf("Vetor: ");
    for(int i=0; i<n; i++){
        printf("| %d ", x[i]);
    }
}
int BuscaSequencialLinear(int *x, int n, int alvo){
    for(int i=0; i<n; i++){
        if(x[i] == alvo){
            return i;
        }
    }
    return -1;
} 
int BuscaSequencialOrdenada(int *x, int n, int alvo){
    for(int i=0; i<n; i++){
        if(x[i] == alvo){
            return i;
        }else{
            if(alvo<x[i]){
                return -1;
            }
        }
    }
    return -1;
} 
int main()
{
    int v[7] = {23,4,67,-8,54,90,21};
    int vo[7] = {-8,4,21,23,54,67,90};
    printf("Inicio.\n");
    ImprimeVetor(v, 7);
    int b = 95;
    printf("\nBusca Linear Sequencial: %d \n", BuscaSequencialLinear(v, 7, b));
    
    
    return 0;
}
