//MULTIPLICACIÓN DE MATRICES(APLANADAS) EN C++ 
#include<iostream>
#include<stdio.h>
#include<malloc.h>
using namespace std; 


void multiplicaMatrices(int* X,int filX,int colX,int* Y,int filY,int colY,int* Z){
	int suma=0;
	for(int i=0;i<filX;i++){
		for(int j=0;j<colY;j++){
			suma=0;
			for(int k=0;k<filY;k++){
				suma=suma+X[(i*colX)+k]*Y[(k*colY)+j];
				cout<<"i:"<<i<<" j:"<<j<<" suma:"<<suma<<" k:"<<k<<" X["<<(i*colX)+k<<"],Y["<<(k*colY)+j<<"]"<<endl;
			}
			Z[(i*colY)+j]=suma;cout<<"Z["<<(i*colY)+j<<"]"<<endl;
		}	
	}
}

void imprime(int* A,int filas, int columnas){//imprime como si fuera una matriz
	for(int i = 0; i < filas; i++){
        	for(int j = 0; j < columnas; j++){
            		cout<<A[(i*columnas)+j]<<" ";
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

	clock_t startCPU,endCPU;  
	int *A,*B,*C; //A[filA][colA],B[filB][colB],C[filA][colB]
	int filA=3,colA=3,filB=3,colB=3;

	startCPU = clock();	

	A=(int*)malloc(filA*colA*sizeof(int)); 
	B=(int*)malloc(filB*colB*sizeof(int));
	C=(int*)malloc(colA*filB*sizeof(int));

	inicializa(A,filA,colA);
	inicializa(B,filB,colB);
	
	if(colA==filB){//para que sean multiplicables
		multiplicaMatrices(A,filA,colA,B,filB,colB,C);
		//imprime(C,filA,colB);
	}else{
		cout<<"Error, no se pueden multiplicar"<<endl;
	}
	
	endCPU = clock();

	double time_CPU=((double)(endCPU-startCPU))/CLOCKS_PER_SEC;
	//cout<<"El tiempo transcurrido en la GPU fue: "<<time_CPU<<endl;
	
	free(A);free(B);free(C);
	return 0;
}

