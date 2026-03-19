#include <stdio.h>

void imprimeBusca(int *x, int n){
    printf("Valor: ");
    for(int i = 0; i < n; i++){
        printf("| %d ", x[i]);
    }
}

int buscaLinearSeq(int *x, int n, int valor){
    for(int i = 0; i < n; i++){
        if(x[i] == valor){
            return i;
        }
    }
    return -1;
}

int main(){
    int v[7] = {23, 4, 67, -8, 54, 90, 21};
    printf("Inicio.\n");
    
    imprimeBusca(v, 7);
    
    int b = 54;
    int resultado = buscaLinearSeq(v, 7, b);
    
    printf("Resultado: %d \n", resultado);

    return 0;
}

//E se tiver ordenado?
#include <stdio.h>

void imprimeBusca(int *x, int n){
    printf("Valor: ");
    for(int i = 0; i < n; i++){
        printf("| %d ", x[i]);
    }
}

int buscaLinearOrd(int *x, int n, int valor){
    for(int i = 0; i < n; i++){
        if(x[i] == valor){
            return i;
        }else{
            if(valor < x[i]){
                return -1;
            }
        }
    }
    return -1;
}

int main(){
    int v[7] = {23, 4, 67, -8, 54, 90, 21};
    int vo[7] = {-8, 4, 21, 23, 54, 67, 90};
    printf("Inicio.\n");
    
    imprimeBusca(v, 7);
    
    int b = -8;
    int resultado = buscaLinearOrd(vo, 7, b);
    
    printf("Resultado: %d \n", resultado);

    return 0;
}

//E se for uma busca binária? (pegar a tabela pela metade e analisar, se valor é menor: buscar no inicio, se maior é maior: buscar no final)
#include <stdio.h>

void imprimeBusca(int *x, int n){
    printf("Valor: ");
    for(int i = 0; i < n; i++){
        printf("| %d ", x[i]);
    }
}

int buscaLinearOrd(int *x, int n, int valor){
    for(int i = 0; i < n; i++){
        if(x[i] == valor){
            return i;
        }else{
            if(valor < x[i]){
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
        
        while (inicio <= fim){
            meio = (inicio+fim)/2;
            
            if(v[meio] == elem){
                return meio;
                
            }else{
                if(elem < v[meio]){
                    fim = meio -1;
                    
                }else{
                    inicio = meio+1;
                }
            }
        }
    return -1;
    }
    
int main(){
    int v[7] = {23, 4, 67, -8, 54, 90, 21};
    int vo[7] = {-8, 4, 21, 23, 54, 67, 90};
    int vb[10] = {-8, -5, 1, 4, 14, 21, 23, 54, 67, 90};
    printf("Inicio.\n");
    
    imprimeBusca(v, 7);
    
    int b = -8;
    int resultado = buscaLinearOrd(vo, 7, b);
    
    printf("Resultado: %d \n", resultado);
    printf("\nBusca binaria: %d \n", buscaBinaria(vb, 10, 14));

    return 0;
    
}
//Aula 05/03
#include <stdio.h>
int buscaBinaria(int *v, int n, int elem){
    int inicio, meio, fim;
    inicio = 0;
    fim = n-1;
    
    int meio = (inicio + fim)/2;
    if(inicio>fim){
        return -1;
    }else if(v[meio] == elem){
        return meio;
    }else{
        if(elem>v[meio]){
            return buscaBinaria(v, n, inicio, meio-1, elem);
        }else{
            if(elem > v[meio]){
                return buscaBinaria)v, n, meio+1, fim, elem);
            }
        }
    }
return -1;
}
    
int main(){
    int v[7] = {23, 4, 67, -8, 54, 90, 21};
    int vo[7] = {-8, 4, 21, 23, 54, 67, 90};
    int vb[10] = {-8, -5, 1, 4, 14, 21, 23, 54, 67, 90};
    printf("Inicio.\n");
    
    imprimeBusca(v, 7);
    
    int b = -8;
    int resultado = buscaLinearOrd(vo, 7, b);
    
    printf("Resultado: %d \n", resultado);
    printf("\nBusca binaria: %d \n", buscaBinaria(vb, 10, 14));

    return 0;
    
}

//Recursivo
#include <stdio.h>
int buscaBinariaRecursiva(int *v, int inicio, int fim, int elem){
    if(inicio>fim){
        return -1;
    }
    
    int meio = (inicio + fim)/2;
    
    if(v[meio] == elem){
        return meio;
    }
    
    if(elem>v[meio]){
        buscaBinariaRecursiva(v, inicio, meio-1, elem);
    }else{
        buscaBinariaRecursiva(v,meio+1, fim, elem;
        }
    }
return -1;
}
    
int main(){
    int v[7] = {23, 4, 67, -8, 54, 90, 21};
    int vo[7] = {-8, 4, 21, 23, 54, 67, 90};
    int vb[10] = {-8, -5, 1, 4, 14, 21, 23, 54, 67, 90};
    printf("Inicio.\n");
    
    imprimeBusca(v, 7);
    
    int b = -8;
    int resultado = buscaLinearOrd(vo, 7, b);
    
    printf("Resultado: %d \n", resultado);
    printf("\nBusca binaria: %d \n", buscaBinaria(vb, 10, 14));

    return 0;
    
}
//
