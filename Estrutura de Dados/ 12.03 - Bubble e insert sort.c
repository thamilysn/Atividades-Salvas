//BubbleSort
#include <stdio.h>

void bubbleSort(int *v, int x){
    int y;
    for(int i = 0; i < x - 1; i++){
        for(int j = 0; j < x - i - 1; j++){
            if(v[j] > v[j + 1]){
                y = v[j];
                v[j] = v[j + 1];
                v[j + 1] = y;
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
#include <stdio.h>

void insertSort(int *v, int x){
    int i;
    int j;
    int y;
    for(i = 1; i < x; i++){
        y = v[i];
        j = i - 1;

        while(j >= 0 && v[j] > y){
            v[j + 1] = v[j];
            j--;
        }

        v[j + 1] = y;
    }
}

int main(){
    int v[7] = {1, 3, 5, 8, 9, 2, 6};

    insertSort(v, 7);

    for(int i = 0; i < 7; i++){
        printf("%d|", v[i]);
    }

    return 0;
}
