#include <stdio.h>
#define ARRAY_SIZE(a) (sizeof(a)/sizeof((a)[0]))

int cube(int i) {
    return i*i*i;
}

int mult(size_t i, int j) {
    return i * j;
}


void apply(int *arr, size_t len, int (*fnPtr)(int)) {
     for(size_t i = 0; i < len; i++) {
         arr[i] = fnPtr(arr[i]);
     }             
};

void apply_enumerate(int *arr, size_t len, int (*fnPtr)(size_t, int)) {
     for(size_t i = 0; i < len; i++) {
         arr[i] = fnPtr(i, arr[i]);
     }             
};


void print_array(int *arr, size_t len, char *sep) {
     if(sep == NULL) {
	sep = ", ";
     }

     printf("%d", *arr);

     for(size_t i = 1; i < len; i++) {
     	printf("%s%d", sep, arr[i]);
     }

     printf("\n"); 
};

int main() {

    int arr[5] = {1,2,3,4,5};
    print_array(arr, ARRAY_SIZE(arr), NULL);
    apply(arr, ARRAY_SIZE(arr), cube);
    print_array(arr, ARRAY_SIZE(arr), NULL);
    apply_enumerate(arr, ARRAY_SIZE(arr), mult);
    print_array(arr, ARRAY_SIZE(arr), NULL);

 return(0);
};
