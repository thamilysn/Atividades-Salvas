
#include <stdio.h>  // Biblioteca para utilizar printf()
#include <stdlib.h> // Biblioteca para utilizar malloc() e free()


/* ============================================================
   PARTE 1 - ARVORE BINARIA
   ============================================================ */


/*
    ESTRUTURA DA ARVORE BINARIA

    Cada no possui tres campos:

    info: armazena o valor do no.
    esq:  ponteiro para o filho esquerdo.
    dir:  ponteiro para o filho direito.

    Cada no pode ter:
    - Nenhum filho;
    - Apenas filho esquerdo;
    - Apenas filho direito;
    - Dois filhos.
*/

typedef struct arv {
    char info;          // Valor armazenado no no
    struct arv* esq;    // Endereco do filho esquerdo
    struct arv* dir;    // Endereco do filho direito
} Arv;                  // Arv passa a ser um apelido para struct arv


/*
    PROTOTIPOS DAS FUNCOES

    Os prototipos informam ao compilador quais funcoes existem,
    seus parametros e seus tipos de retorno.

    Isso permite utilizar as funcoes antes de suas definicoes.
*/

Arv* arv_criavazia(void);
Arv* arv_cria(char c, Arv* sae, Arv* sad);
int arv_vazia(Arv* a);
int arv_pertence(Arv* a, char c);
void arv_imprime(Arv* a);
void arv_imprime_emordem(Arv* a);
void arv_imprime_posordem(Arv* a);
Arv* arv_libera(Arv* a);
int arv_altura(Arv* a);


/*
    1. CRIAR UMA ARVORE VAZIA

    Uma arvore vazia e representada por NULL.

    NULL significa que o ponteiro nao aponta para nenhum no.

    A funcao retorna NULL porque ainda nao existe nenhum
    elemento na arvore.
*/

Arv* arv_criavazia(void) {
    return NULL;
}


/*
    2. CRIAR UM NO

    Parametros:
    c   = informacao que sera armazenada no no.
    sae = subarvore a esquerda.
    sad = subarvore a direita.

    malloc() reserva um espaco na memoria suficiente
    para armazenar uma estrutura Arv.

    p recebe o endereco desse espaco de memoria.

    Depois, os campos do no sao preenchidos.

    Por ultimo, a funcao retorna o endereco do novo no.
*/

Arv* arv_cria(char c, Arv* sae, Arv* sad) {

    // Reserva memoria para um novo no
    Arv* p = malloc(sizeof(Arv));

    // Armazena o caractere recebido no campo info
    p->info = c;

    // Conecta a subarvore esquerda ao novo no
    p->esq = sae;

    // Conecta a subarvore direita ao novo no
    p->dir = sad;

    // Retorna o endereco do no criado
    return p;
}


/*
    3. VERIFICAR SE A ARVORE ESTA VAZIA

    Uma arvore esta vazia quando seu ponteiro e NULL.

    A expressao a == NULL retorna:
    1 (verdadeiro), se estiver vazia.
    0 (falso), se possuir um no.
*/

int arv_vazia(Arv* a) {

    return a == NULL;
}


/*
    4. VERIFICAR SE UM ELEMENTO PERTENCE A ARVORE

    Parametros:
    a = arvore que sera pesquisada.
    c = caractere que queremos encontrar.

    Primeiro, verificamos se a arvore esta vazia.
    Se estiver, o elemento nao pode existir nela.

    Caso contrario, verificamos tres possibilidades:

    1. O elemento esta no no atual.
    2. O elemento esta na subarvore esquerda.
    3. O elemento esta na subarvore direita.

    O operador || significa OU.

    A recursividade faz a busca continuar pelos filhos.
*/

int arv_pertence(Arv* a, char c) {

    // Caso-base: arvore vazia
    if (arv_vazia(a))
        return 0;

    // Verifica o no atual e depois os dois filhos
    return a->info == c ||
           arv_pertence(a->esq, c) ||
           arv_pertence(a->dir, c);
}


/*
    5. IMPRESSAO EM PRE-ORDEM

    Ordem:
    1. Raiz
    2. Esquerda
    3. Direita

    Primeiro imprime o valor do no atual.
    Depois percorre a subarvore esquerda.
    Por ultimo percorre a subarvore direita.

    O caso-base e a arvore vazia:
    se o ponteiro for NULL, nao existe nada para imprimir.
*/

void arv_imprime(Arv* a) {

    if (!arv_vazia(a)) {

        // Primeiro imprime a raiz
        printf("%c ", a->info);

        // Depois percorre o filho esquerdo
        arv_imprime(a->esq);

        // Por ultimo percorre o filho direito
        arv_imprime(a->dir);
    }
}


/*
    6. IMPRESSAO EM ORDEM SIMETRICA

    Ordem:
    1. Esquerda
    2. Raiz
    3. Direita

    Diferentemente da pre-ordem, a raiz e impressa
    somente depois de percorrer o filho esquerdo.
*/

void arv_imprime_emordem(Arv* a) {

    if (!arv_vazia(a)) {

        // Percorre primeiro a subarvore esquerda
        arv_imprime_emordem(a->esq);

        // Imprime o no atual
        printf("%c ", a->info);

        // Percorre depois a subarvore direita
        arv_imprime_emordem(a->dir);
    }
}


/*
    7. IMPRESSAO EM POS-ORDEM

    Ordem:
    1. Esquerda
    2. Direita
    3. Raiz

    A raiz e impressa somente depois que
    as duas subarvores forem percorridas.
*/

void arv_imprime_posordem(Arv* a) {

    if (!arv_vazia(a)) {

        // Percorre a subarvore esquerda
        arv_imprime_posordem(a->esq);

        // Percorre a subarvore direita
        arv_imprime_posordem(a->dir);

        // Imprime o no atual por ultimo
        printf("%c ", a->info);
    }
}


/*
    8. LIBERAR A MEMORIA DA ARVORE

    Cada no criado com malloc() ocupa memoria.

    Quando nao precisamos mais da arvore,
    devemos liberar essa memoria utilizando free().

    A funcao libera primeiro:
    1. A subarvore esquerda.
    2. A subarvore direita.
    3. O proprio no.

    Isso e feito porque precisamos liberar os filhos
    antes de liberar o no que aponta para eles.

    No final, retornamos NULL.
*/

Arv* arv_libera(Arv* a) {

    if (!arv_vazia(a)) {

        // Libera todos os nos da esquerda
        arv_libera(a->esq);

        // Libera todos os nos da direita
        arv_libera(a->dir);

        // Libera o no atual
        free(a);
    }

    // Retorna NULL para indicar que a arvore foi liberada
    return NULL;
}


/*
    9. CALCULAR A ALTURA DA ARVORE

    Convencao utilizada:
    Arvore vazia = -1.
    No folha = 0.

    A altura e calculada a partir da maior altura
    entre a subarvore esquerda e a direita.

    O resultado recebe +1 porque precisamos contar
    a aresta que liga o no atual ao seu filho.

    Exemplo:

           A
          /
         B
        /
       C

    C possui altura 0.
    B possui altura 1.
    A possui altura 2.
*/

int arv_altura(Arv* a) {

    // Caso-base: arvore vazia
    if (arv_vazia(a))
        return -1;

    // Calcula a altura da subarvore esquerda
    int he = arv_altura(a->esq);

    // Calcula a altura da subarvore direita
    int hd = arv_altura(a->dir);

    // Compara as alturas e retorna a maior + 1
    if (he > hd)
        return he + 1;

    else
        return hd + 1;
}


/* ============================================================
   PARTE 2 - ARVORE N-ARIA
   REPRESENTACAO: PRIMEIRO FILHO E PROXIMO IRMAO
   ============================================================ */


/*
    ESTRUTURA DA ARVORE N-ARIA

    Diferentemente da arvore binaria, uma arvore N-aria
    pode possuir varios filhos.

    Nesta representacao, utilizamos dois ponteiros:

    info = valor armazenado no no.
    prim = aponta para o primeiro filho.
    prox = aponta para o proximo irmao.

    Exemplo:

             A
           / | \
          B  C  D

    A->prim aponta para B.
    B->prox aponta para C.
    C->prox aponta para D.
    D->prox aponta para NULL.

    B, C e D sao irmaos.
*/

typedef struct arvvar {
    char info;             // Valor armazenado no no
    struct arvvar* prim;  // Ponteiro para o primeiro filho
    struct arvvar* prox;  // Ponteiro para o proximo irmao
} ArvVar;


/*
    PROTOTIPOS DAS FUNCOES N-ARIAS
*/

ArvVar* arvv_cria(char c);
void arvv_insere(ArvVar* a, ArvVar* sa);
void arvv_imprime(ArvVar* a);
int arvv_pertence(ArvVar* a, char c);
void arvv_libera(ArvVar* a);
int arvv_altura(ArvVar* a);


/*
    10. CRIAR UM NO N-ARIO

    Recebe um caractere e cria um novo no.

    malloc() reserva memoria para a estrutura.

    info recebe o caractere.

    prim e prox recebem NULL porque o novo no
    ainda nao possui filhos nem irmaos.
*/

ArvVar* arvv_cria(char c) {

    // Aloca memoria para um novo no
    ArvVar* a = malloc(sizeof(ArvVar));

    // Armazena o valor no no
    a->info = c;

    // Inicialmente, nao existem filhos
    a->prim = NULL;

    // Inicialmente, nao existem irmaos
    a->prox = NULL;

    // Retorna o endereco do no criado
    return a;
}


/*
    11. INSERIR UM FILHO NA ARVORE N-ARIA

    Parametros:
    a  = no que recebera o novo filho.
    sa = novo filho que sera inserido.

    A insercao acontece no INICIO da lista de filhos.

    Exemplo inicial:

    A -> B

    Queremos inserir C como filho de A.

    Primeiro:
    sa->prox = a->prim;

    Isso faz C apontar para B.

    Depois:
    a->prim = sa;

    Isso faz A apontar para C.

    Resultado:

    A -> C -> B

    IMPORTANTE:
    Como a insercao acontece no inicio, a ordem dos
    filhos fica invertida em relacao a ordem das chamadas.
*/

void arvv_insere(ArvVar* a, ArvVar* sa) {

    // O novo filho aponta para o antigo primeiro filho
    sa->prox = a->prim;

    // O novo filho passa a ser o primeiro filho
    a->prim = sa;
}


/*
    12. IMPRIMIR A ARVORE N-ARIA

    Primeiro imprime o valor do no atual.

    Depois percorre todos os filhos utilizando um for.

    p comeca apontando para o primeiro filho (prim).

    Enquanto p nao for NULL:
    - Imprime recursivamente o filho atual.
    - Avanca para o proximo irmao utilizando prox.

    Quando todos os filhos forem percorridos,
    o laco termina.

    A verificacao a == NULL evita acessar um ponteiro invalido.
*/

void arvv_imprime(ArvVar* a) {

    // Variavel que percorrera os filhos
    ArvVar* p;

    // Caso-base: nao existe no para imprimir
    if (a == NULL)
        return;

    // Imprime a informacao do no atual
    printf("<%c\n", a->info);

    // Percorre todos os filhos do no atual
    for (p = a->prim; p != NULL; p = p->prox) {

        // Imprime recursivamente cada filho
        arvv_imprime(p);
    }

    // Fecha a representacao do no
    printf(">");
}


/*
    13. VERIFICAR SE UM ELEMENTO PERTENCE A ARVORE N-ARIA

    Primeiro verifica se o no e NULL.
    Se for, retorna 0.

    Depois verifica se o valor do no atual
    e igual ao caractere procurado.

    Caso nao seja, percorre todos os filhos.

    O for percorre a lista de irmaos:
    p = p->prox.

    A funcao retorna 1 assim que encontrar o elemento.

    Se terminar a busca sem encontrar, retorna 0.
*/

int arvv_pertence(ArvVar* a, char c) {

    // Ponteiro utilizado para percorrer os filhos
    ArvVar* p;

    // Caso-base: no inexistente
    if (a == NULL)
        return 0;

    // Verifica o valor do no atual
    if (a->info == c)
        return 1;

    // Percorre todos os filhos do no atual
    for (p = a->prim; p != NULL; p = p->prox) {

        // Procura recursivamente dentro do filho
        if (arvv_pertence(p, c))
            return 1;
    }

    // Se chegou ate aqui, o elemento nao foi encontrado
    return 0;
}


/*
    14. LIBERAR A MEMORIA DA ARVORE N-ARIA

    Primeiro verificamos se o no e NULL.

    Depois, p recebe o primeiro filho.

    O while percorre todos os filhos e irmaos.

    A variavel t guarda o endereco do proximo irmao
    ANTES de liberar o filho atual.

    Isso e importante porque, depois de free(p),
    nao devemos acessar p->prox.

    Depois de liberar todos os filhos, liberamos
    o proprio no atual.
*/

void arvv_libera(ArvVar* a) {

    // Ponteiro para percorrer os filhos
    ArvVar* p;

    // Caso-base: no inexistente
    if (a == NULL)
        return;

    // Comeca pelo primeiro filho
    p = a->prim;

    // Percorre todos os filhos e seus irmaos
    while (p != NULL) {

        // Guarda o endereco do proximo irmao
        ArvVar* t = p->prox;

        // Libera o filho atual e toda sua descendencia
        arvv_libera(p);

        // Avanca para o proximo irmao
        p = t;
    }

    // Depois de liberar os filhos, libera o no atual
    free(a);
}


/*
    15. CALCULAR A ALTURA DA ARVORE N-ARIA

    A altura e a maior distancia entre o no atual
    e uma folha descendente.

    Convencao:
    Arvore vazia = -1.
    No folha = 0.

    hmax comeca em -1 porque ainda nao encontramos filhos.

    O for percorre todos os filhos.

    Para cada filho, calculamos sua altura recursivamente.

    Se a altura encontrada for maior que hmax,
    atualizamos hmax.

    No final, retornamos hmax + 1.

    O +1 conta o nivel do no atual.
*/

int arvv_altura(ArvVar* a) {

    // Guarda a maior altura encontrada entre os filhos
    int hmax = -1;

    // Ponteiro para percorrer os filhos
    ArvVar* p;

    // Caso-base: arvore vazia
    if (a == NULL)
        return -1;

    // Percorre todos os filhos do no atual
    for (p = a->prim; p != NULL; p = p->prox) {

        // Calcula a altura do filho atual
        int h = arvv_altura(p);

        // Guarda a maior altura encontrada
        if (h > hmax)
            hmax = h;
    }

    // Retorna a maior altura dos filhos + 1
    return hmax + 1;
}


/* ============================================================
   PARTE 3 - EXEMPLO DE UTILIZACAO
   ============================================================ */


/*
    A funcao main() e o ponto de entrada do programa.

    Nela, criamos as arvores e chamamos as funcoes
    para testar seus comportamentos.
*/

int main(void) {


    /* --------------------------------------------------------
       EXEMPLO 1 - ARVORE BINARIA

                  A
                 / \
                B   C
               /
              D

       -------------------------------------------------------- */


    /*
        Criamos a arvore de baixo para cima.

        Primeiro criamos D.
        Depois criamos B, conectando D a esquerda.
        Depois criamos C.
        Finalmente criamos A, conectando B e C.

        NULL significa que aquele filho nao existe.
    */

    Arv* binaria = arv_cria(
        'A',

        // Subarvore esquerda de A
        arv_cria(
            'B',
            arv_cria('D', NULL, NULL),
            NULL
        ),

        // Subarvore direita de A
        arv_cria('C', NULL, NULL)
    );


    printf("ARVORE BINARIA\n");

    // Percurso: raiz, esquerda, direita
    printf("Pre-ordem: ");
    arv_imprime(binaria);

    // Percurso: esquerda, raiz, direita
    printf("\nEm ordem: ");
    arv_imprime_emordem(binaria);

    // Percurso: esquerda, direita, raiz
    printf("\nPos-ordem: ");
    arv_imprime_posordem(binaria);

    // Calcula a altura da arvore
    printf("\nAltura: %d", arv_altura(binaria));

    // Verifica se D pertence a arvore
    printf("\nPertence D? %d", arv_pertence(binaria, 'D'));

    // Libera a memoria da arvore
    binaria = arv_libera(binaria);


    /* --------------------------------------------------------
       EXEMPLO 2 - ARVORE N-ARIA

                  A
                / | \
               B  C  D
              / \
             E   F

       -------------------------------------------------------- */


    /*
        Primeiro criamos todos os nos individualmente.

        Neste momento, cada no ainda esta isolado.
    */

    ArvVar* naria = arvv_cria('A');

    ArvVar* B = arvv_cria('B');
    ArvVar* C = arvv_cria('C');
    ArvVar* D = arvv_cria('D');

    ArvVar* E = arvv_cria('E');
    ArvVar* F = arvv_cria('F');


    /*
        Agora conectamos os nos.

        A funcao arvv_insere() insere sempre no inicio.

        Por isso, precisamos inserir os filhos na ordem
        inversa para obter o desenho desejado.

        Inserimos D primeiro.
        Depois C.
        Por ultimo B.

        Resultado: A -> B -> C -> D
    */

    arvv_insere(naria, D);
    arvv_insere(naria, C);
    arvv_insere(naria, B);


    /*
        Fazemos a mesma coisa com os filhos de B.

        Inserimos F primeiro.
        Depois E.

        Resultado: B -> E -> F
    */

    arvv_insere(B, F);
    arvv_insere(B, E);


    // Imprime a arvore N-aria
    printf("\n\nARVORE N-ARIA\n");
    arvv_imprime(naria);

    // Calcula a altura da arvore N-aria
    printf("\nAltura: %d", arvv_altura(naria));

    // Verifica se E pertence a arvore
    printf("\nPertence E? %d", arvv_pertence(naria, 'E'));

    // Libera todos os nos da arvore
    arvv_libera(naria);


    // Indica que o programa terminou corretamente
    return 0;
}
