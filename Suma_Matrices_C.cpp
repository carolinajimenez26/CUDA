//PROGRAMA QUE SUMA DOS MATRICES EN C++
#include<iostream>
#include<malloc.h>
#include<time.h>
using namespace std; 


void SumaMatrices(int** A,int** B,int** C,int x,int y){
	for(int i=0;i<x;i++)
		for(int j=0;j<y;j++){
			C[i][j]=A[i][j]+B[i][j];
		}

}

void imprimeMatriz(int** A, int x, int y){
	for(int i=0;i<x;i++){
		for(int j=0;j<y;j++){
			cout<<A[i][j]<<" ";
		}
		cout<<endl;
	}

}

void inicializaMatriz(int** X,int filas, int columnas){//la llena de ceros
	for(int i=0;i<filas;i++){
		for(int j=0;j<columnas;j++){
			X[i][j]=1;
		}
	}

}

int main(void){
	clock_t start, end;
	int **A,**B,**C,x=2000,y=1500;

	//iniciamos la cuenta del reloj
	start = clock();

	A=(int**)malloc(x*sizeof(int*));//reservamos memoria
	for(int i=0;i<x;i++){
		A[i]=(int*)malloc(y*sizeof(int*));
	}
	B=(int**)malloc(x*sizeof(int*));//reservamos memoria
	for(int i=0;i<x;i++){
		B[i]=(int*)malloc(y*sizeof(int*));
	}
	C=(int**)malloc(x*sizeof(int*));//reservamos memoria
	for(int i=0;i<x;i++){
		C[i]=(int*)malloc(y*sizeof(int*));
	}

	inicializaMatriz(A,x,y);
	inicializaMatriz(B,x,y);
	SumaMatrices(A,B,C,x,y);

	//terminamos la cuenta del reloj
	end = clock();

	imprimeMatriz(C,x,y);

	cout<<"El tiempo transcurrido fue: "<<((double)(end-start))/CLOCKS_PER_SEC<<endl;

	return 0;

}

