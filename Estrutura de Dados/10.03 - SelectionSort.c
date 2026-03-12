//SelectionSort
#include <stdio.h>

void bubbleSort(int *v, int x){
    int y;
    for(int i = 0; i < x; i++){
        for(int j=0; j < x; j++){
            if(v[i] > v[j]){
                y = v[i];
                v[i] = v[j];
                v[j] = y;
            }
        }
    }
}

int main()
{
    int v[7] = {1, 3, 5, 8, 9, 2, 6};
    bubbleSort(v, 7);
    for(int i = 0; i < 7; i++)
    printf("%d|", v[i]);

    return 0;
}
