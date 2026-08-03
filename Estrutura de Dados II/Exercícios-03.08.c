/*1)Sabendo que:
f(1) = 1
f(2) = 1
f(n) = f(n-2) + f(n-1) V n >= 2
prove que f(n+4) = 3f(n+2) - f(N) V N >= 1*/

f(n+4)=f(n+3)+f(n+2).
f(n+3)=f(n+2)+f(n+1),

f(n+4)=2f(n+2)+f(n+1).
f(n+2)=f(n+1)+f(n)
f(n+1)=f(n+2)−f(n).

f(n+4)
=2f(n+2)+(f(n+2)−f(n))
=3f(n+2)−f(n).
	
f(n+4)=3f(n+2)−f(n)

CQD: (n+4) f= f(n+3) + f(n+2)

/*2) Define uma operação recorrente para a multiplicação de dois inteiros positivos.*/
M(a,b) = a + M(a, b−1), b > 1

//3) Implemente em C a operação definida em 2).
#include <stdio.h>

int multiplica(int a, int b) {
    if (b == 1)
        return a;
    return a + multiplica(a, b - 1);
}

int main() {
    int a, b;

    printf("Digite dois inteiros positivos: ");
    scanf("%d %d", &a, &b);

    printf("Resultado = %d\n", multiplica(a, b));

    return 0;
}

/*4) Implemente em C uma função recursiva que retorna o maior elemento de um vetor de tamanho n.*/
#include <stdio.h>

int maior(int v[], int n) {
    if (n == 1)
        return v[0];

    int m = maior(v, n - 1);

    if (v[n - 1] > m)
        return v[n - 1];

    return m;
}

int main() {
    int v[] = {5, 15, 30, 60, 120};
    int n = 5;

    printf("Maior elemento = %d\n", maior(v, n));

    return 0;
}

/*5) Recursão de Ackemann: A(m, n) = {n+1, se m = 0; 
                                      A(m-1), se m > 0 e n = 0; 
                                      A(m-1, A(m, n-1), se m > 0 e n >0}
Calcule:*/

/*a) A(0,n)*/
A(0, n) = n + 1

/*b) A(1,n)*/
A(1, n) = n + 2

/*c) A(2,n)*/
A(2, n) = 2n + 3

/*d) A(3,n)*/
A(3,n)=2^(n+3)−3

/*e) A(2,1)*/
A(2,1) = 5
