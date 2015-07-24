//SUMA DE MATRICES EN C++
#include<iostream>
#include<stdio.h>
#include<malloc.h>
//#include<cuda.h>
using namespace std; 

void suma(int* A,int* B,int* C,int filas,int columnas){//Para sumar dos matrices deben tener las mismas dimensiones
	for(int i = 0; i < filas ; i++){
        	for(int j = 0; j < columnas ; j++){
                	C[(i*columnas)+j]=A[(i*columnas)+j]+B[(i*columnas)+j];
        	}
   	}
}

void imprime(int* A,int filas, int columnas){//imprime como si fuera una matriz
	for(int i = 0; i < filas; i++){
        	for(int j = 0; j < columnas; j++){
            		cout<<A[(i*columnas)+j];
        	}
        cout<<endl;
    }
}	

void inicializa(int *A,int filas, int columnas){//inicializa arreglos
	for(int i=0;i<filas*columnas;i++){
		A[i]=1;
	}
}

int main(void){
	int *A,*B,*C;
	int filas=2,columnas=4,SIZE=filas*columnas*sizeof(int);

	A=(int*)malloc(SIZE); 
	B=(int*)malloc(SIZE);
	C=(int*)malloc(SIZE);

	inicializa(A,filas,columnas);
	inicializa(B,filas,columnas);	

	suma(A,B,C,filas,columnas);
	imprime(C,filas,columnas);	

	return 0;
}

