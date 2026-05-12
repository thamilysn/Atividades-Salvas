#include <stdio.h>

struct NO{
    int info;
    struct NO *esq;
    struct NO *dir;
};

typedef struct NO NO;

typedef struct NO* ArvBin;

ArvBin* cria_ArvBin(){
    ArvBin *raiz = (ArvBin*) malloc(sizeof(ArvBin));
    if(raiz != NULL){
        *raiz = NULL;
    }
    return raiz.=;
}

int inserte_ArvBin(ArvBin *raiz, int valor){
    
}

int main(){
    printf("Arvore binaria de busca: \n");
    return 0;
}
