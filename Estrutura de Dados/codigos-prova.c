//Busca Sequencial
int BuscaSequencialLinear(int *x, int n, int alvo){
    for(int i=0; i<n; i++){
        if(x[i] == alvo){
            return i;
        }
    }
    return -1;
} 

//Busca Ordenada
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

//Busca Binária
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

//Busca Binária Recursiva
#include <stdio.h>
int buscaBinariaRecursiva(int *v, int inicio, int fim, int elem){
    if(inicio>fim){
        return -1;
    }
    
    int meio = (inicio + fim)/2;
    if(v[meio] == elem){
        return meio;
    }
    
    if(elem > v[meio]){
        buscaBinariaRecursiva(v, inicio, meio-1, elem);
      
    }else{
        buscaBinariaRecursiva(v,meio+1, fim, elem;
        }
    }
return -1;
}

//Selection Sort
void selectionSort(int *v, int n){
    int i , j, menor, troca;
    for(i=0; i<n-1;i++){
        menor = i;
        for(j=i+1; j<n ; j++ ){
            if(v[j]<v[menor]){
                menor = j;
            }
        }
        if(i!=menor){
            troca = v[i];
            v[i] = v[menor];
            v[menor] = troca;
        }
        
    }
}

//Bubble Sort
void bubbleSort(int *v, int x){
    int y;
    for(int i = 0; i < x - 1; i++){
        for(int j = 0; j < x - i - 1; j++){
            if(v[j] > v[j + 1]){
                y = v[j];
                v[j] = v[j + 1];
                v[j + 1] = y;
            }
        }
    }
}

//InsertionSort
#include <stdio.h>

void insertSort(int *v, int x){
    int i, j, y;
  
    for(i = 1; i < x; i++){
        y = v[i];
        j = i - 1;

        while(j >= 0 && v[j] > y){
            v[j + 1] = v[j];
            j--;
        }

        v[j + 1] = y;
    }
}

//MergeSort
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void merge(int *v, int inicio, int meio, int fim){
    int *temp, i, j, k, tamanho, p1, p2;
    tamanho = fim - inicio + 1;
    p1 = inicio;
    p2 = meio + 1;
    temp = (int*)malloc(tamanho * sizeof(int));

    if(temp != NULL){
        for(i = 0; i < tamanho; i++){
            int fim1 = (p1 > meio);
            int fim2 = (p2 > fim);

            if(!fim1 && !fim2){
                if(v[p1] <= v[p2]){
                    temp[i] = v[p1++];
                } else {
                    temp[i] = v[p2++];
                }
            } else if(!fim1){
                temp[i] = v[p1++];
            } else {
                temp[i] = v[p2++];
            }
        }

        for(j = 0, k = inicio; j < tamanho; j++, k++){
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

//QuickSort
int particiona(int *v, int inicio, int fim){
    int esq, dir, pivo, aux;
    esq = inicio;
    dir = fim;
    pivo = v[inicio];

    while(esq < dir){
        while(esq <= fim && v[esq] <= pivo){
            esq++;
        }

        while(dir >= 0 && v[dir] > pivo){
            dir--;
        }

        if(esq < dir){
            aux = v[esq];
            v[esq] = v[dir];
            v[dir] = aux;
        }
    }

    aux = v[inicio];
    v[inicio] = v[dir];
    v[dir] = aux;

    return dir;
}

void quickSort(int *v, int inicio, int fim){
    int pivo;
    if(fim > inicio){
        pivo = particiona(v, inicio, fim);
        quickSort(v, inicio, pivo - 1);
        quickSort(v, pivo + 1, fim);
    }
}
