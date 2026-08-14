#include <stdio.h>
#include <stdlib.h>

struct Aluno{
    char nome[100];
    float nota;
};

#define TAM sizeof(Aluno); 

int main(){
    FILE *pont;
    int i, numero;
    
    pont = fopen("alunos.dat", "wb");
    
    for (i = 0; i < TAM; i++) {
        printf("Nome: ");
        scanf(" %[^\n]", aluno.nome);

        printf("Nota: ");
        scanf("%f", &aluno.nota);

        fwrite(&aluno, sizeof(struct Aluno), 1, pont);
    }
    
    fclose(pont);
    
    printf("Digite o numero do aluno (1 a 50): ");
    scanf("%d", &numero);

    if (numero < 1 || numero > 50) {
        printf("Numero invalido.\n");
        return 1;
    }
    pont = fopen("alunos.dat", "rb");

    if (fseek(pont,
              (numero - 1) * sizeof(struct Aluno),
              SEEK_SET)) {

        printf("Erro na busca!\n");
    }
    else {
        fread(&aluno, sizeof(struct Aluno), 1, pont);

        printf("\nAluno encontrado:\n");
        printf("Nome: %s\n", aluno.nome);
        printf("Nota: %.2f\n", aluno.nota);
    }

    fclose(pont);
    return 0;
}
