#include <stdio.h>
#include <stdlib.h>

struct Aluno {
    char nome[100];
    float nota;
};

#define TAM 50

int main() {
    FILE *pont;
    struct Aluno aluno;
    int i, numero;

    pont = fopen("alunos.dat", "wb");

    if (pont == NULL) {
        printf("Erro ao abrir o arquivo.\n");
        return 1;
    }

    for (i = 0; i < TAM; i++) {
        printf("\nAluno %d\n", i + 1);

        printf("Nome: ");
        scanf(" %[^\n]", aluno.nome);

        printf("Nota: ");
        scanf("%f", &aluno.nota);

        fwrite(&aluno, sizeof(struct Aluno), 1, pont);
    }

    fclose(pont);

    printf("\nDigite o numero do aluno (1 a 50): ");
    scanf("%d", &numero);

    if (numero < 1 || numero > TAM) {
        printf("Numero de aluno invalido.\n");
        return 1;
    }

    pont = fopen("alunos.dat", "rb");

    if (pont == NULL) {
        printf("Erro ao abrir o arquivo.\n");
        return 1;
    }

    fseek(pont, (numero - 1) * sizeof(struct Aluno), SEEK_SET);

    if (fread(&aluno, sizeof(struct Aluno), 1, pont) == 1) {
        printf("\nNome: %s\n", aluno.nome);
        printf("Nota: %.2f\n", aluno.nota);
    } else {
        printf("Erro ao ler o aluno.\n");
    }

    fclose(pont);

    return 0;
}
