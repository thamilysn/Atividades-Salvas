/** Escreva uma função em C que realiza uma busca binária em um vetor de inteiros. A 
função deve receber como parâmetros o vetor, o tamanho do vetor e o valor a ser 
buscado, caso o valor não seja encontrado, a função retorne o índice do elemento 
imediatamente superior ao valor buscado. Por exemplo, se o vetor contém os valores 
1, 2, 5, 7, 9 e o valor buscado é 6, a função deve retornar o índice 3, correspondente 
ao valor 7. **/

int buscaBinaria(int *v, int n, int elem){
    int inicio, meio, fim;
    inicio = 0;
    fim = n-1;
    
    while(inicio<=fim){
        
        meio = (inicio + fim)/2; //precisa estar no while para calcular em cada iteração

        if(v[meio] == elem){
            return meio;
        }
        
        if(v[meio] < elem){
            inicio = meio + 1; //ir pra direita
        }
        
        else{
            fim = meio-1; //ir pra esquerda
        }
    }
    
    return inicio;
}

/** Implemente busca binária recursiva em vetor crescente v[0..n-1]. **/
int buscaBinariaRecursiva(int *v, int menor, int maior, int fim, int elem){
    
    if(inicio > fim){
        return -1;
    }
    
    int meio = (inicio + fim) / 2;

    if(v[meio] == elem){
        return meio;
    }
    
    if(v[meio] < x){
        return buscaBinariaRecursiva(v*, meio + 1, fim, x);
    }
    return buscaBinariaRecursiva(v*, inicio, meio - 1, x);
}

/**Escreva uma implementação iterativa de busca binária que procure x num 
vetor decrescente v[0..n-1].**/

int buscaBinariaDes(int *v, int x, int elem){
  int inicio, meio, fim;
  inicio = 0;
  fim = x - 1;
  
  while(inicio <= fim){
      meio = (inicio + fim) / 2;
      
      if (v[meio] == elem){
          return meio;
      }
      
      if(v[meio] < elem){
          fim = meio - 1;
      }
      
      else{
          fim = meio + 2
      }
  }
  return inicio;
}
