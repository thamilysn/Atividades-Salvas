
void merge(int *v, int inicio, int meio, int fim){
    int i, j, tamanho, *temp, p1, p2;
    tamanho = fim - inicio + 1;
    p1 = inicio;
    p2 = meio + 1;
    temp = (int) malloc(tamanho * sizeof(int));
        if(temp != NULL){
            //incompleto
        }
    
}

void mergeSort(int *v, int inicio, int fim){
    int meio;
    if (inicio < fim){
        meio = floor((inicio+fim)/2);
        mergeSort(V, inicio, meio);
        mergeSort(V, meio+1, fim);
        merge(V, inicio, meio, fim);
        
        
    }
}
