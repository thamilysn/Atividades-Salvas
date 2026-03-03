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
