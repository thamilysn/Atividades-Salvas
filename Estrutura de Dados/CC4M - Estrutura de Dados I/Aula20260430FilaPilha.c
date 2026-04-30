#include <stdio.h>
#include <stdlib.h>
//codigo pra liberar lista de tras pra frente.
//---------------------------------
/*typedef struct cel{
  int conteudo;
  struct cel *seg;
}cel;

typedef struct cel* Lista;*/
//---------------------------------
struct elemento{
  int conteudo;
  struct elemento *prox;
};
typedef struct elemento Elem;

typedef struct elemento* Pilha;

struct fila{
  struct elemento *inicio;
  struct elemento *fim;
  int qtd;
};
typedef struct fila Fila;
//---------------------------------

Pilha* cria_pilha(){
  Pilha *pi = (Pilha*) malloc(sizeof(Pilha));
  if(pi != NULL){
    *pi=NULL;
  }
  return pi;
}

void libera_pilha(Pilha* pi){
  if(pi!=NULL){
    Elem* aux;
    while(*pi!=NULL){
      aux = *pi;
      *pi =(*pi)->seg;
      free(aux);
    }
    free(pi);
  }
}

int consulta_topo(Pilha* pi){
    if(pi==NULL){ return -1;}
    if((*pi)==NULL){ return -1;}
    return (*pi)->conteudo;
}

int push (Pilha* pi, int x){
    if(pi==NULL){ return -1;}
    Elem *no = (Elem*) malloc(sizeof(Elem));
    if(no==NULL){ return -1;}

    no->conteudo = x;
    no->prox = (*pi);

    *pi = no;

    return 1;
}

int pop (Pilha* pi){
    if(pi==NULL){ return -1;}
    if((*pi)==NULL){ return -1;}

    Elem *no = *pi;
    *pi = no->prox;

    int valor = no->conteudo;
    free(no);

    return valor;
}
//---------------------------------
Fila* cria_fila(){
  Fila *fi = (Fila*) malloc(sizeof(Fila));
  if(fi != NULL){
    fi->fim=NULL;
    fi->inicio=NULL;
    fi->qtd=0;
  }
  return fi;
}

void libera_fila(Fila* fi){
  if(fi!=NULL){
    Elem* no;
    while(fi->inicio!=NULL){
      no = fi->inicio;
      fi->inicio = fi->inicio->prox;
      free(no);
    }
    free(fi);
  }
}

int enqueue(Fila* fi, int x){
    if(fi == NULL){return -1;}

    Elem *no = (Elem*) malloc(sizeof(Elem));
    if(no==NULL){ return -1;}
    no->conteudo = x;
    no->prox = NULL;

    if(fi->inicio == NULL){
        fi->inicio = no;
    }

    fi->fim->prox = no;

    fi->fim = no;
    fi->qtd++;

    return 1;
}
int dequeue(Fila* fi){
    if(fi == NULL){return -1;}
    if(fi->inicio == NULL){return -1;}

    Elem *no = fi->inicio;
    fi->inicio = fi->inicio->prox; //fi->inicio = no->prox;

    if(fi->inicio == NULL){
        fi->fim = NULL;
    }

    free(no);
    fi->qtd--;

    return 1;
}

int main()
{
    printf("Hello world!\n");
    printf("Hello world!\n");
    printf("Hello world!\n");
    return 0;
}
