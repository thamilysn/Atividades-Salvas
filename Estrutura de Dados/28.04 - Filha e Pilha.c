/******************************************************************************

Welcome to GDB Online.
  GDB online is an online compiler and debugger tool for C, C++, Python, PHP, Ruby, 
  C#, OCaml, VB, Perl, Swift, Prolog, Javascript, Pascal, COBOL, HTML, CSS, JS
  Code, Compile, Run and Debug online from anywhere in world.

*******************************************************************************/
#include <stdio.h>
#include <stdlib.h>

struct elemento{
    int conteudo;
    struct elemento *prox;
};

typedef struct elemento Elem;

typedef struct elemento* Pilha;

//criar pilha
Pilha* cria_pilha(){
    Pilha pi = (Pilha*) malloc(sizeof(Pilha));
    if(li != NULL){
        *pi = NULL;
    }
    return pi;
}

//liberar pilha
void libera_pilha(Pilha* pi){
    if(pi != NULL){
        Elem* aux;
        while(*pi != NULL){
            aux = *pi;
            *pi = (*pi) -> seg;
            free(aux);
        }
        free(pi);
    }
}

int consulta_topo(Pilha* pi){
    if(pi == NULL){ return -1; }
    if((*pi) == NULL){ return -1; }
    return (*pi) -> conteudo;
}

//push da pilha e pop

int push(Pilha* pi, int valor){
    if(pi == NULL){ return -1; }
    Elem *no = (Elem*) malloc(sizeof(Elem));
    if(no == NULL){ return -1; }
    
    no -> conteudo = valor;
    no -> prox = (*pi);
    *pi = no;
    
    return 1;
}

int pop(Pilha pi*){
    if(pi == NULL){ return -1; }
    if((*pi) == NULL){ return -1; }
    
    Elem *no = *pi;
    *pi = no -> prox;
    
    int valor = no -> conteudo;
    free(no);
    
    /**outra opção pode ser:
    free(no);
    return 1;  **/
    
    return valor;
}

//codigo pra fila
struct fila{
    struct elemento *inicio;
    struct elemento *fim;
    int qnt;
};

typedef struct fila Fila;

Fila cria_fila(){
    Fila fi* = (Fila*) malloc(sizeof(Fila));
    if(fi != NULL){
        fi -> fim = NULL;
        fi -> inicio = NULL;
        fi -> qnt = 0;
    }
    return fi;
}

struct fila{
    struct elemento *inicio;
    struct elemento *fim;
    int qnt;
};

typedef struct fila Fila;

void libera_fila(Fila* fi){
    if(fi != NULL){
        Elem* no;
        
        while(fi -> inicio != NULL){
            no = fi -> inicio;
            fi -> inicio = fi -> inicio -> prox;
            free(no);
        }
        free(fi);
    }
}

//enfileirar e desinfileirar

int enqueue(Fila* fi, int valor){
    if(fi == NULL){ return -1; }
    
    Elem *no = (Elem*) malloc(sizeof(Elem));
    if(no == NULL) { return -1; }
    no -> conteudo = valor;
    no -> prox = NULL;
    
    if(fi -> inicio == NULL){
        fi -> inicio = no;
    }
    
    fi -> fim -> prox = no;
    
    fi -> fim = no;
    fi -> qnt++;
    
    return 1;
}

int dequeue(Fila* fi){
    if(fi == NULL) { return -1; }
    if(fi -> inicio == NULL) { return -1; }
    
    Elem *no = fi -> inicio;
    fi -> inicio = fi -> inicio -> prox; //fi -> inicio = no -> prox;
    
    if(fi -> inicio == NULL){
        fi -> fim = NULL;
    }
    
    free(no);
    fi -> qnt--;
    
    return 1;
}
