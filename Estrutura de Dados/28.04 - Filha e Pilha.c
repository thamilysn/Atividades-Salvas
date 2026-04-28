#include <stdio.h>
#include <stdlib.h>

struct elemento{
    int conteudo;
    struct elemento *prox;
};

typedef struct elemento Elem;

typedef struct elemento* Pilha;

struct fila{
    struct elemento *inicio;
    struct elemento *fim;
    int qnt
}

typedef struct fila Fila;
