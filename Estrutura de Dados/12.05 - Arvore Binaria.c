/******************************************************************************

Welcome to GDB Online.
  GDB online is an online compiler and debugger tool for C, C++, Python, PHP, Ruby, 
  C#, OCaml, VB, Perl, Swift, Prolog, Javascript, Pascal, COBOL, HTML, CSS, JS
  Code, Compile, Run and Debug online from anywhere in world.

*******************************************************************************/
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

int inserte_ArvBin(ArvBin* raiz, int valor){
    if(raiz == NULL){
        return 0;
    }
    
    NO *novo = (NO*) malloc(sizeof(NO));
    if(novo == NULL){
        return 0;
    }
    
    novo -> info = valor;
    novo -> esq = NULL;
    novo -> dir = NULL;
    
    if(*raiz == NULL){
        *raiz = novo;
    }
    else{
        NO *atual = *raiz;
        NO *ant = NULL;
        while(atual != NULL){
            ant = atual;
            if(valor == atual -> info){
                free(novo);
                return 0;
            }
            if(valor > atual -> info){
                atual = atual -> dir;
            }
            else{
                atual = atual -> esq;
            }
        }
        if(valor > ant -> info){
            ant -> dir = novo;
        }
        else{
            ant -> esq = novo;
        }
    }
    return 1;
}

int consulta_ArvBin(ArvBin* raiz){
    if(raiz == NULL){
        return 0;
    }
    
    if(*raiz == NULL){
        return 0;
    }
    else{
        NO *atual = *raiz;
        while(atual != NULL){
            if(valor == atual -> info){
                return 1;
            }
            if(valor > atual -> info){
                atual = atual -> dir;
            }
            else{
                atual = atual -> esq;
            }
        }
    }
    return 0;
}

int totalNosArvBin(ArvBin* raiz){
    if (raiz == NULL){
        return 0;
    }
    if (*raiz == NULL){
        return 0;
    }
    
    int nos_esq = totalNosArvBin(&((*raiz)-> esq));
    int nos_dir = totalNosArvBin(&((*raiz)-> dir));
    
    return nos_esq + nos_dir + 1;
}

int altura_ArvBin(ArvBin* raiz){
    return 1;
}

int preOrdemArvBin(ArvBin* raiz){
    return 1;
}

int emOrdemArvBin(ArvBin* raiz){
    return 1;
}

int posOrdemArvBin(ArvBin* raiz){
    return 1;
}

int main(){
    printf("Arvore binaria de busca: \n");
    return 0;
}
