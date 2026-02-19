//exercicio 1
#include <stdio.h>
int main()
{
    int a = 5;
    int b = 10;
    int temp;
    
    temp = a;
    a = b;
    b = temp;

    printf("O valor de A é: %d e o de B é %d", a, b);
    
    return 0;
}

//exercicio 2
#include <stdio.h>
int main()
{
    float notas[4];
    int i;
    printf("Digite as notas: \n");
    for (i = 0; i < 4; i++){
        printf("Notas dos estudantes %d: ", i);
        scanf("%f", &notas[i]);
    }
    
    float media = 0;
    for(i = 0; i < 4; i++){
        media = media + notas[i];
        media = media / 4;
    }
    
    for(i = 0; i < 4; i++){
        if notas([i] > media)
        printf("Notas: %f \n", notas[i]);
    }
    
    return 0
}
