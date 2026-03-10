//SelectionSort
#include <stdio.h>

int SelectionSort(int *v, int x){
    int y;
    
    for(int i = 0; i < x; i++){
        for(int j = 0; j < x; j++){
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
    int v[7] = {7, 4, 5, 9, 8, 2, 1};
    SelectionSort(v, 7);
    for(int i = 0; i < 7; i++)
    printf("Os valores são: %d \n", v[i]);

    return 0;
}
