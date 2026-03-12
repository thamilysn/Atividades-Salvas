//BubbleSort
#include <stdio.h>

void bubbleSort(int *v, int x){
    int temp;
    for(int i = 0; i < x - 1; i++){
        for(int j = 0; j < x - i - 1; j++){
            if(v[j] > v[j + 1]){
                temp = v[j];
                v[j] = v[j + 1];
                v[j + 1] = temp;
            }
        }
    }
}

int main()
{
    int v[7] = {1, 3, 5, 8, 9, 2, 6};

    bubbleSort(v, 7);

    for(int i = 0; i < 7; i++){
        printf("%d|", v[i]);
    }

    return 0;
}

//InsertionSort
