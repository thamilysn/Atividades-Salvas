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

int buscaBinaria(int *v, int n, int elem){
     int inicio, meio, fim;
     inicio = 0;
     fim = n-1;
     while(inicio<=fim){
        meio = (inicio+fim)/2;
        if(v[meio] == elem){
            return meio;
        }else{
            if(elem<v[meio]){
                fim = meio-1;
            }else{
                inicio = meio+1;
            }
        }
     }
     return -1;
}

int buscaBinariaRecursiva(int *v, int inicio, int fim, int elem){
    if(inicio>fim){
        return -1;
    }
    
    int meio = (inicio+fim)/2;
    
    if(v[meio]==elem){
        return meio;
    }
    
    if(elem<v[meio]){
        buscaBinariaRecursiva(v, inicio,meio-1,elem);
    }else{
        buscaBinariaRecursiva(v, meio+1,fim,elem);
    }
}



int main()
{
    int v[7] = {23,4,67,-8,54,90,21};
    int vo[7] = {-8,4,21,23,54,67,90};
    int vb[10] = {-8,-5,1,4,14,21,23,54,67,90};
    printf("Inicio.\n");
    ImprimeVetor(v, 7);
    int b = 95;
    printf("\nBusca Linear Sequencial: %d \n", BuscaSequencialLinear(v, 7, b));
    printf("\nBusca binaria: %d \n", buscaBinaria(vb, 10, 95));

    
    return 0;
}
