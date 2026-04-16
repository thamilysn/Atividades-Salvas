#include <stdio.h>
#include<stdlib.h>


//codigo pra liberar lista de tras pra frente.

typedef struct cel{
  int conteudo;
  struct cel *seg;
}cel;

typedef struct cel* Lista;

void imprime_lista(Lista* lista){
  printf("\nx");
  if(lista==NULL){
    printf("\n1");
    return;
  }
  cel* aux = *lista;
  printf("\n2");
  while(aux!=NULL){
    printf("\t%i",aux->conteudo);
    aux=aux->seg;
  }
  printf("\n");
}

Lista* cria_lista(){
  Lista *li = (Lista*) malloc(sizeof(Lista));
  if(li != NULL){
    *li=NULL;
  }
  return li;
}

int insere_lista_fim(Lista* lista, int x){
  if(lista==NULL) {return 0;}
  cel* aux = (cel*) malloc(sizeof(cel));
  if(aux==NULL){return 0;}
  aux->conteudo = x;
  aux->seg = NULL;
  if((*lista)==NULL){ *lista = aux;}
  else{
    cel *temp;
    temp = *lista;
    while(temp->seg!= NULL){ //caminha até o utlimo elemento
      temp= temp->seg;
    }
    temp->seg = aux;
  }
  return 1;
}

int insere_lista_inicio(Lista* lista, int x) {
  if (lista == NULL) { return 0; }

  cel* aux = (cel*) malloc(sizeof(cel));
  if (aux == NULL) { return 0; }

  aux->conteudo = x;
  aux->seg = *lista;

  *lista = aux;
  return 1;

}
int busca(Lista *lista, int valor){
  cel *p;
  for(p=*lista;p!=NULL;p=p->seg){
    if(p->conteudo == valor){
      return 1;
    }
  }
  return 0;
}

int main(void) {
  Lista *lst;
  lst = cria_lista();
  insere_lista_fim(lst, 1);
  insere_lista_fim(lst, 2);
  insere_lista_fim(lst, 3);
  insere_lista_fim(lst, 4);
  insere_lista_fim(lst, 5);
  imprime_lista(lst);

  //remove_lista(lst,4);
  imprime_lista(lst);
  printf("\nA busca retornou %d\n",busca(lst,7));
  //libera_lista(lst);
  imprime_lista(lst);

  return 0;
}
