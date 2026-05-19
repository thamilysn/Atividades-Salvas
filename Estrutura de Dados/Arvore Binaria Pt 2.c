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
    if(raiz == NULL){ return -1; }
    if(*raiz == NULL){ return -1; }
    
    int alt_esq = altura_ArvBin(&((*raiz) -> esq));
    int alt_dir = altura_ArvBin(&((*raiz) -> dir));
    
    if(alt_esq > alt_dir){
        return(alt_esq + 1);
    }else{
        return(alt_dir + 1);
    }
    return 1;
}

int preOrdemArvBin(ArvBin* raiz){
    if(raiz == NULL){
        return;
    }

    if(*raiz != NULL){
        printf("%d\t", (*raiz)->info);
        preOrdemArvBin(&((*raiz)->esq));
        preOrdemArvBin(&((*raiz)->dir));
    }
}

int emOrdemArvBin(ArvBin* raiz){
    if(raiz == NULL){
        return;
    }

    if(*raiz != NULL){
        emOrdemArvBin(&((*raiz)->esq));
        printf("%d\t", (*raiz)->info);
        emOrdemArvBin(&((*raiz)->dir));
    }
}

int posOrdemArvBin(ArvBin* raiz){
    if(raiz == NULL){
        return;
    }

    if(*raiz != NULL){
        posOrdemArvBin(&((*raiz)->esq));
        posOrdemArvBin(&((*raiz)->dir));
        printf("%d\t", (*raiz)->info);
    }
}

NO* remove_atual(No *atual){
    NO *no1, *no2;
    
    if(atual -> esq == NULL){
        no2 = atual -> dir;
        free(atual);
        return no2;
    }
    
    no1 = atual;
    no2 = atual -> esq;
    
    while(no2 -> dir != NULL){
        no1 = no2;
        no2 = no2 -> dir;
    }
    
    if(no1 != atual){
        no1 -> dir = no2 -> esq;
        no2 -> esq = atual -> esq;
    }
    
    no2 -> dir = atual -> dir;
    free(atual);
    
    return no2;
}

remove_ArvBin(ArvBin *raiz, int valor){
    if(raiz == NULL){
        return 0;
    }
    
    NO *ant = NULL;
    NO *atual = *raiz;
    
    while(atual != NULL){
        if(valor == atual -> info){
            if(atual == *raiz){
                *raiz = remove_atual(atual);
            }else{
                if(ant -> dir == atual){
                    ant -> dir = remove_atual(atual);
                }else{
                    ant -> esq = remove_atual(atual);
                }
            }
        }
        ant = atual;
        if(valor > atual -> info){
            atual = atual -> dir;
        }else{
            atual = atual -> esq;
        }
    }
    return 0;
}

int main(){
    ArvBin* raiz = cria_ArvBin();
    int N = 10, dados[10] = {28, 16, 40, 11, 21, 36, 48, 19, 32, 56};
    for(int i = 0; i < N; i++){
        inserte_ArvBin(raiz, dados[i]);
    }
    
    printf("Arvore binaria de busca: \n", x);

    return 0;
}
