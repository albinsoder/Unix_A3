#include <stdio.h>

int main(){
    int a=732;
    int b=2684;
    while(a != b) {
    if(a > b) {
        a=a-b;
        printf("A: %d", a);
    } else {
        b=b-a;
        printf("B: %d", b);
    }
    }

}

