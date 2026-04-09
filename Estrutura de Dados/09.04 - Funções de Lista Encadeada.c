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
