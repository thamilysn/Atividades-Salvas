//codigo pra liberar lista de tras pra frente
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
    
    while(aux != NULL){
        if(aux->conteudo == x){
            return 1; //se encontrar, é 1
        }
        aux = aux->seg;
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

void libera_lista(Lista *lista){
    if(lista != NULL){
        cel *aux;
        while(*lista != NULL){
            aux = *lista;
            *lista = (*lista) -> seg;
            free(aux);
        }
        free(lista);
    }
}

int remove_lista(Lista *lista, int x){
    if(lista == NULL) {return 0;}
    if(*lista == NULL) {return 0;}

    cel *aux = *lista;
    cel *ant = NULL;

    while(aux != NULL && aux->conteudo != x){
        ant = aux;
        aux = aux->seg;
    }

    if(aux == NULL) {return 0;}

    if(aux == *lista){
        *lista = aux->seg;
    } else {
        ant->seg = aux->seg;
    }

    free(aux);
    return 1;
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
  return 0;
}

//implementar as alterações necessárias em cada uma das funções para que ela seja completamente encadeada
