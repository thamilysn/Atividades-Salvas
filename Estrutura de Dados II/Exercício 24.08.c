/******************************************************************************

Welcome to GDB Online.
  GDB online is an online compiler and debugger tool for C, C++, Python, PHP, Ruby, 
  C#, OCaml, VB, Perl, Swift, Prolog, Javascript, Pascal, COBOL, HTML, CSS, JS
  Code, Compile, Run and Debug online from anywhere in world.

*******************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int id;
    int matricula;
    char nome[40];
    float media;
} Aluno;

//Implemente uma função que: Abra o arquivo texto fornecido. Leia todos os registros de alunos. 
//Crie um arquivo binário chamado alunos.dat.Grave cada registro utilizando a função fwrite.
//Exiba ao final a quantidade de registros gravados.void criarArquivoBinario(void)
{
    FILE *texto, *binario;
    Aluno aluno;
    char linha[200];
    int quantidade = 0;

    texto = fopen("alunos.txt", "r");
    if (texto == NULL) {
        printf("Erro ao abrir alunos.txt.\n");
        return;
    }

    binario = fopen("alunos.dat", "wb");
    if (binario == NULL) {
        printf("Erro ao criar alunos.dat.\n");
        fclose(texto);
        return;
    }

    fgets(linha, sizeof(linha), texto);

    while (fgets(linha, sizeof(linha), texto) != NULL) {

        linha[strcspn(linha, "\n")] = '\0';

        if (sscanf(linha, "%d;%d;%39[^;];%f",
                   &aluno.id,
                   &aluno.matricula,
                   aluno.nome,
                   &aluno.media) == 4) {

            if (fwrite(&aluno, sizeof(Aluno), 1, binario) == 1) {
                quantidade++;
            }
        }
    }

    fclose(texto);
    fclose(binario);

    printf("Quantidade de registros gravados: %d\n", quantidade);
}

//Implemente uma função que: Solicite ao usuário uma matrícula. Percorra o arquivo binário utilizando leitura sequencial com fread.
//Localize o aluno cuja matrícula foi informada. Exiba: ID, Matrícula, Nome, Média Quantidade de registros lidos durante a busca
//Caso a matrícula não exista, informe que o aluno não foi encontrado.

void buscarPorMatricula(void)
{
    FILE *arquivo;
    Aluno aluno;
    int matricula;
    int registrosLidos = 0;
    int encontrado = 0;

    printf("Digite a matricula: ");
    scanf("%d", &matricula);

    arquivo = fopen("alunos.dat", "rb");

    if (arquivo == NULL) {
        printf("Erro ao abrir alunos.dat.\n");
        return;
    }

    while (fread(&aluno, sizeof(Aluno), 1, arquivo) == 1) {

        registrosLidos++;

        if (aluno.matricula == matricula) {
            printf("\nAluno encontrado!\n");
            printf("ID: %d\n", aluno.id);
            printf("Matricula: %d\n", aluno.matricula);
            printf("Nome: %s\n", aluno.nome);
            printf("Media: %.2f\n", aluno.media);
            printf("Quantidade de registros lidos: %d\n",
                   registrosLidos);

            encontrado = 1;
            break;
        }
    }

    if (!encontrado) {
        printf("\nAluno nao encontrado.\n");
        printf("Quantidade de registros lidos: %d\n",
               registrosLidos);
    }

    fclose(arquivo);
}


//c) Sabendo que os registros possuem tamanho fixo, implemente uma função que:
//Solicite ao usuário um RRN (Relative Record Number). Posicione diretamente o ponteiro de arquivo utilizando fseek.
//Recupere o registro correspondente com fread. Exiba todas as informações do aluno encontrado.

void buscarPorRRN(void)
{
    FILE *arquivo;
    Aluno aluno;
    int rrn;

    printf("Digite o RRN (0 a 99): ");
    scanf("%d", &rrn);

    if (rrn < 0 || rrn >= 100) {
        printf("RRN invalido. O arquivo possui 100 registros.\n");
        return;
    }

    arquivo = fopen("alunos.dat", "rb");

    if (arquivo == NULL) {
        printf("Erro ao abrir alunos.dat.\n");
        return;
    }

    if (fseek(arquivo, (long)rrn * sizeof(Aluno), SEEK_SET) != 0) {
        printf("Erro ao posicionar no registro.\n");
        fclose(arquivo);
        return;
    }

    if (fread(&aluno, sizeof(Aluno), 1, arquivo) == 1) {
        printf("\nAluno encontrado!\n");
        printf("ID: %d\n", aluno.id);
        printf("Matricula: %d\n", aluno.matricula);
        printf("Nome: %s\n", aluno.nome);
        printf("Media: %.2f\n", aluno.media);
    } else {
        printf("Erro ao ler o registro.\n");
    }

    fclose(arquivo);
}


//d) Implemente uma funcionalidade que permita alterar a média de um aluno diretamente no arquivo binário utilizando o RRN, 
//sem recarregar todos os registros para a memória.

void alterarMediaPorRRN(void)
{
    FILE *arquivo;
    Aluno aluno;
    int rrn;
    float novaMedia;

    printf("Digite o RRN (0 a 99): ");
    scanf("%d", &rrn);

    if (rrn < 0 || rrn >= 100) {
        printf("RRN invalido. O arquivo possui 100 registros.\n");
        return;
    }

    arquivo = fopen("alunos.dat", "r+b");

    if (arquivo == NULL) {
        printf("Erro ao abrir alunos.dat.\n");
        return;
    }

    /*
     * Primeiro posiciona no registro desejado.
     */
    if (fseek(arquivo, (long)rrn * sizeof(Aluno), SEEK_SET) != 0) {
        printf("Erro ao posicionar no registro.\n");
        fclose(arquivo);
        return;
    }

    /*
     * Lê o registro para obter os dados atuais.
     */
    if (fread(&aluno, sizeof(Aluno), 1, arquivo) != 1) {
        printf("Erro ao ler o registro.\n");
        fclose(arquivo);
        return;
    }

    printf("\nAluno selecionado:\n");
    printf("ID: %d\n", aluno.id);
    printf("Matricula: %d\n", aluno.matricula);
    printf("Nome: %s\n", aluno.nome);
    printf("Media atual: %.2f\n", aluno.media);

    printf("\nDigite a nova media: ");
    scanf("%f", &novaMedia);

    aluno.media = novaMedia;

    /*
     * Depois do fread, o ponteiro está no início do próximo
     * registro. Voltamos sizeof(Aluno) bytes para sobrescrever
     * o registro atual.
     */
    if (fseek(arquivo, -(long)sizeof(Aluno), SEEK_CUR) != 0) {
        printf("Erro ao reposicionar o arquivo.\n");
        fclose(arquivo);
        return;
    }

    if (fwrite(&aluno, sizeof(Aluno), 1, arquivo) == 1) {
        printf("Media alterada com sucesso!\n");
    } else {
        printf("Erro ao gravar o registro.\n");
    }

    fclose(arquivo);
}


/* =========================================================
   Programa principal
   ========================================================= */
int main(void)
{
    int opcao;

    do {
        printf("\n========== MENU ==========\n");
        printf("1 - Criar arquivo binario\n");
        printf("2 - Buscar por matricula\n");
        printf("3 - Buscar por RRN\n");
        printf("4 - Alterar media por RRN\n");
        printf("0 - Sair\n");
        printf("===========================\n");
        printf("Opcao: ");
        scanf("%d", &opcao);

        switch (opcao) {

            case 1:
                criarArquivoBinario();
                break;

            case 2:
                buscarPorMatricula();
                break;

            case 3:
                buscarPorRRN();
                break;

            case 4:
                alterarMediaPorRRN();
                break;

            case 0:
                printf("Programa encerrado.\n");
                break;

            default:
                printf("Opcao invalida.\n");
        }

    } while (opcao != 0);

    return 0;
}
