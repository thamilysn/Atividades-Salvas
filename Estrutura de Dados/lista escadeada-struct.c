/******************************************************************************

Welcome to GDB Online.
  GDB online is an online compiler and debugger tool for C, C++, Python, PHP, Ruby, 
  C#, OCaml, VB, Perl, Swift, Prolog, Javascript, Pascal, COBOL, HTML, CSS, JS
  Code, Compile, Run and Debug online from anywhere in world.

*******************************************************************************/
#include <stdio.h>
#include <stdlib.h>

struct celula{
    int conteudo;
    struct celula *seg;    
} cel;

typedef struct *cel lista;

lista* criar_lista(){
    lista *li = (lista*) malloc (sizeof(lista));
    if(li != NULL){
        *li == NULL;
    }
    return li;
}

int main()
{
    
    lista *lst;
    lst = criar_lista();
    
    cel c1, c2, c3;
    c1.conteudo = 10;
    c2.conteudo = 20;
    c3.conteudo = 30;
    
    c1.seg = &c2;
    c2.seg = &c3;
    c3.seg = NULL;
    
    *lst = &c1;
    cel* aux = *lst;
    
    printf("\n Minha lista: \n");
    while(aux != NULL){
        printf("\t %d", aux -> conteudo);
        aux = aux -> seg;
        
    }
    
    return 0;
}
