#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define TAM_NOME 40
#define NUM_ALUNOS 100

typedef struct aluno {
    int id;
    int matricula;
    char nome[TAM_NOME];
    float media;
} aluno;


//a) criar o arquivo binário a partir de alunos.txt

void criarArquivo()
{
    FILE *arquivoTexto = fopen("alunos.txt", "r");
    FILE *arquivoBinario = fopen("alunos.dat", "wb");

    if (arquivoTexto == NULL) {
        printf("erro ao abrir alunos.txt\n");
        return;
    }

    if (arquivoBinario == NULL) {
        printf("erro ao criar alunos.dat!\n");
        fclose(arquivoTexto);
        return;
    }

    aluno a;
    char linha[200];
    int quantidade = 0;

    fgets(linha, sizeof(linha), arquivoTexto);

    while (fgets(linha, sizeof(linha), arquivoTexto) != NULL) {

        if (sscanf(linha, "%d;%d;%39[^;];%f",
                   &a.id,
                   &a.matricula,
                   a.nome,
                   &a.media) == 4) {

            fwrite(&a, sizeof(aluno), 1, arquivoBinario);

            quantidade++;
        }
    }

    fclose(arquivoTexto);
    fclose(arquivoBinario);

    printf("\narquivo criado.\n");
    printf("quantidade de registros gravados: %d\n", quantidade);
}


//b) busca sequencial pela matricula

void buscarMatricula()
{
    FILE *arquivo = fopen("alunos.dat", "rb");

    if (arquivo == NULL) {
        printf("erro ao abrir alunos.dat.\n");
        return;
    }

    int matricula;
    int encontrados = 0;
    aluno a;

    printf("\ndigite a matricula que deseja encontrar: ");
    scanf("%d", &matricula);

    while (fread(&a, sizeof(aluno), 1, arquivo) == 1) {

        encontrados++;

        if (a.matricula == matricula) {

            printf("\naluno encontrado\n");
            printf("ID: %d\n", a.id);
            printf("Matricula: %d\n", a.matricula);
            printf("Nome: %s\n", a.nome);
            printf("Media: %.2f\n", a.media);

            printf("quantidade de registros lidos: %d\n",
                   encontrados);

            fclose(arquivo);
            return;
        }
    }

    printf("\naluno nao encontrado.\n");
    printf("quantidade de registros lidos: %d\n",
           encontrados);

    fclose(arquivo);
}


//c) busca direta utilizando RRN
void buscarRRN()
{
    FILE *arquivo = fopen("alunos.dat", "rb");

    if (arquivo == NULL) {
        printf("erro ao abrir alunos.dat.\n");
        return;
    }

    int rrn;
    aluno a;

    printf("\ndigite o RRN (de 0 a 99): ");
    scanf("%d", &rrn);

    if (rrn < 0 || rrn >= NUM_ALUNOS) {
        printf("RRN invalido.\n");
        fclose(arquivo);
        return;
    }

    long tamanhoRegistro = sizeof(aluno);

    long posicao = rrn * tamanhoRegistro;

    fseek(arquivo, posicao, SEEK_SET);

    if (fread(&a, sizeof(aluno), 1, arquivo) == 1) {

        printf("\naluno encontrado\n");
        printf("ID: %d\n", a.id);
        printf("Matricula: %d\n", a.matricula);
        printf("Nome: %s\n", a.nome);
        printf("Media: %.2f\n", a.media);

    } else {
        printf("\nerro ao ler o registro.\n");
    }

    fclose(arquivo);
}


//d) Alterar media utilizando RRN

void alterarMedia()
{
    FILE *arquivo = fopen("alunos.dat", "r+b");

    if (arquivo == NULL) {
        printf("erro ao abrir alunos.dat.\n");
        return;
    }

    int rrn;
    float novaMedia;
    aluno a;

    printf("\ndigite o RRN (de 0 a 99): ");
    scanf("%d", &rrn);

    if (rrn < 0 || rrn >= NUM_ALUNOS) {
        printf("RRN invalido.\n");
        fclose(arquivo);
        return;
    }

    long tamanhoRegistro = sizeof(aluno);
    long posicao = rrn * tamanhoRegistro;

    fseek(arquivo, posicao, SEEK_SET);
    
    if (fread(&a, sizeof(aluno), 1, arquivo) != 1) {
        printf("erro ao ler o registro.\n");
        fclose(arquivo);
        return;
    }

    printf("\naluno selecionado:\n");
    printf("ID: %d\n", a.id);
    printf("Matricula: %d\n", a.matricula);
    printf("Nome: %s\n", a.nome);
    printf("Media atual: %.2f\n", a.media);

    printf("\ndigite a nova media: ");
    scanf("%f", &novaMedia);

    a.media = novaMedia;

    fseek(arquivo, posicao, SEEK_SET);

    fwrite(&a, sizeof(aluno), 1, arquivo);

    printf("\nmedia alterada com sucesso.\n");

    fclose(arquivo);
}

int main()
{
    int opcao;

    do {

        printf("SISTEMA DE ALUNOS\n");
        printf("1 - Criar arquivo binario\n");
        printf("2 - Buscar por matricula\n");
        printf("3 - Buscar por RRN\n");
        printf("4 - Alterar media por RRN\n");
        printf("0 - Sair\n");

        printf("Digite uma opcao: ");
        scanf("%d", &opcao);

        switch (opcao) {

            case 1:
                criarArquivo();
                break;

            case 2:
                buscarMatricula();
                break;

            case 3:
                buscarRRN();
                break;

            case 4:
                alterarMedia();
                break;

            case 0:
                printf("\nencerrando programa...\n");
                break;

            default:
                printf("\nopcao invalida.\n");
        }

    } while (opcao != 0);

    return 0;
}
