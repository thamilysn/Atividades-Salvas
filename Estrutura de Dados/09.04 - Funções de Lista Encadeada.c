//Função de inserir no início da lista
#include <stdio.h>
#include <stdlib.h>

typedef struct cel{
    int conteudo;
    struct cel *seg;
}cel;

typedef struct cel* Lista;

Lista* cria_lista(){
    Lista *li = (Lista*) malloc (sizeof(Lista));
    if(li != NULL){
        *li = NULL;
    }
    return li;
}

int insere_lista_fim(Lista *lista, int x){
    if(lista == NULL){ return 0; }
    
    cel* aux = (cel*) malloc (sizeof(cel));
    if(aux == NULL){ return 0; }
    
    aux -> conteudo = x;
    aux -> seg = NULL;
    
    if((*lista) == NULL){
        *lista = aux;
    }else{
        cel *temp;
        temp = *lista;
        while(temp -> seg != NULL){
            temp = temp -> seg;
        }
        temp -> seg = aux;
    }
    return 1;
}

int insere_lista_inicio(Lista *lista, int x){ // <---
    if(lista == NULL){ return 0; }
    
    cel* aux = (cel*) malloc (sizeof(cel));
    if(aux == NULL){ return 0; }
    
    aux -> conteudo = x;
    aux -> seg = *lista;
    
    *lista = aux;
    return 1;
}

void imprimir_lista(Lista* lista){
    if(lista == NULL){
        printf("Lista não existe \n");
    }
    else{
        if(*lista == NULL){
            printf("\nLista Vazia\n");
        }else{
            
            cel *temp;
            temp = *lista;
            printf("\n Lista: ");
            
            while(temp != NULL){
                printf("%d |", temp -> conteudo);
                temp = temp -> seg;
            }
            printf("\n");
        }
    }
}

int main()
{
    printf("Inicio\n");

    Lista *lst;
    lst = cria_lista();
    
    insere_lista_fim(lst, 1);
    insere_lista_fim(lst, 2);
    insere_lista_fim(lst, 3);
    insere_lista_fim(lst, 4);
    insere_lista_fim(lst, 5);
    
    insere_lista_inicio(lst, 0);
    imprimir_lista(lst);
    return 0;
}

//Função de busca na lista: Se encontrar, retorna 1; Se não encontrar, retorna 0;
#include <stdio.h>
#include <stdlib.h>

typedef struct cel{
    int conteudo;
    struct cel *seg;
}cel;

typedef struct cel* Lista;

Lista* cria_lista(){
    Lista *li = (Lista*) malloc (sizeof(Lista));
    if(li != NULL){
        *li = NULL;
    }
    return li;
}

int insere_lista_fim(Lista *lista, int x){
    if(lista == NULL){ return 0; }
    
    cel* aux = (cel*) malloc (sizeof(cel));
    if(aux == NULL){ return 0; }
    
    aux -> conteudo = x;
    aux -> seg = NULL;
    
    if((*lista) == NULL){
        *lista = aux;
    }else{
        cel *temp;
        temp = *lista;
        while(temp -> seg != NULL){
            temp = temp -> seg;
        }
        temp -> seg = aux;
    }
    return 1;
}

int insere_lista_inicio(Lista *lista, int x){
    if(lista == NULL){ return 0; }
    
    cel* aux = (cel*) malloc (sizeof(cel));
    if(aux == NULL){ return 0; }
    
    aux -> conteudo = x;
    aux -> seg = *lista;
    
    *lista = aux;
    return 1;
}

void imprimir_lista(Lista* lista){
    if(lista == NULL){
        printf("Lista não existe \n");
    }
    else{
        if(*lista == NULL){
            printf("\nLista Vazia\n");
        }else{
            
            cel *temp;
            temp = *lista;
            printf("\nLista: ");
            
            while(temp != NULL){
                printf("%d |", temp -> conteudo);
                temp = temp -> seg;
            }
            printf("\n");
        }
    }
}

//exemplo com while
int busca_while(Lista *lista, int x){
    if(lista == NULL) { return 0; }
    if(*lista == NULL) { return 0; }
    
    cel *aux = *lista; 
    
    while(aux -> seg != NULL){
        if(aux->conteudo == x){
            return 1; //se encontrar, é 1
        }else{
            aux = aux -> seg;
        }
    }
    return 0; //se não, retorna 0
}

//exemplo com for
int busca_for(Lista* lista, int x){
    if(lista == NULL) { return 0; }
    cel *aux;

    for(aux = *lista; aux != NULL; aux = aux->seg){
        if(aux->conteudo == x){
            return 1; // se encontrar, retorna 1
        }
    }
    return 0; // se não encontrar, retorna 0
}


int main()
{
    printf("Inicio\n");

    Lista *lst;
    lst = cria_lista();
    
    insere_lista_fim(lst, 1);
    insere_lista_fim(lst, 2);
    insere_lista_fim(lst, 3);
    insere_lista_fim(lst, 4);
    insere_lista_fim(lst, 5);
    
    insere_lista_inicio(lst, 0);
    imprimir_lista(lst);
    
    printf("%d", busca_while(lst, 0));
    return 0;
}

//Função de contar itens na lista
#include <stdio.h>
#include <stdlib.h>

typedef struct cel{
    int conteudo;
    struct cel *seg;
}cel;

typedef struct cel* Lista;

Lista* cria_lista(){
    Lista *li = (Lista*) malloc (sizeof(Lista));
    if(li != NULL){
        *li = NULL;
    }
    return li;
}

int insere_lista_fim(Lista *lista, int x){
    if(lista == NULL){ return 0; }
    
    cel* aux = (cel*) malloc (sizeof(cel));
    if(aux == NULL){ return 0; }
    
    aux -> conteudo = x;
    aux -> seg = NULL;
    
    if((*lista) == NULL){
        *lista = aux;
    }else{
        cel *temp;
        temp = *lista;
        while(temp -> seg != NULL){
            temp = temp -> seg;
        }
        temp -> seg = aux;
    }
    return 1;
}

int insere_lista_inicio(Lista *lista, int x){
    if(lista == NULL){ return 0; }
    
    cel* aux = (cel*) malloc (sizeof(cel));
    if(aux == NULL){ return 0; }
    
    aux -> conteudo = x;
    aux -> seg = *lista;
    
    *lista = aux;
    return 1;
}

void imprimir_lista(Lista* lista){
    if(lista == NULL){
        printf("Lista não existe \n");
    }
    else{
        if(*lista == NULL){
            printf("\nLista Vazia\n");
        }else{
            
            cel *temp;
            temp = *lista;
            printf("\nLista: ");
            
            while(temp != NULL){
                printf("%d |", temp -> conteudo);
                temp = temp -> seg;
            }
            printf("\n");
        }
    }
}

int busca_while(Lista *lista, int x){
    if(lista == NULL) { return 0; }
    if(*lista == NULL) { return 0; }
    
    cel *aux = *lista; 
    
    while(aux -> seg != NULL){
        if(aux->conteudo == x){
            return 1; //se encontrar, é 1
        }else{
            aux = aux -> seg;
        }
    }
    return 0; //se não, retorna 0
}

int contar_lista(Lista *lista){
    if(lista == NULL) { return 0; }
    if(*lista == NULL) { return 0; }

    int cont = 0;
    cel *aux = *lista;

    while(aux != NULL){
        cont++;
        aux = aux->seg;
    }

    return cont;
}

int main()
{
    printf("Inicio: \n");

    Lista *lst;
    lst = cria_lista();
    
    insere_lista_fim(lst, 1);
    insere_lista_fim(lst, 2);
    insere_lista_fim(lst, 3);
    insere_lista_fim(lst, 4);
    insere_lista_fim(lst, 5);
    
    insere_lista_inicio(lst, 0);
    imprimir_lista(lst);
    
    printf("%d", busca_while(lst, 0));
    printf("\nTotal de elementos: %d\n", contar_lista(lst));
    
    return 0;
}

//Função de remover itens da lista
