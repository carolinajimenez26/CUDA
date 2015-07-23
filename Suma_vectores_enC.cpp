//SUMA DE VECTORES EN C+++
#include<iostream>
#include<stdlib.h>
#include<time.h>

using namespace std;

int SIZE=1024;//tamaño de los vectores


void inicializaVec(int* X){
	srand(time(NULL));
	for(int i=0;i<SIZE;i++){
                X[i]=rand()%10;
        }
}

void SumaVec(int* X,int* Y,int* Z){
	for(int i=0;i<SIZE;i++){
                Z[i]=X[i]+Y[i];
        }

} 

void imprimeVec(int* X){
        for(int i=0;i<SIZE;i++){
                cout<<X[i]<<" ";
        }
}


int main(void){
	clock_t start, end;
	int* A;int* B;int* C;//vectores a los cuales se le van a realizar las operaciones

	//iniciamos la cuenta del reloj
	start = clock();

	A=(int*)malloc(SIZE*sizeof(int)); 
	B=(int*)malloc(SIZE*sizeof(int));
	C=(int*)malloc(SIZE*sizeof(int));
	
	inicializaVec(A);
	inicializaVec(B);

	SumaVec(A,B,C);
	//terminamos la cuenta del reloj
	end = clock();

	imprimeVec(C);
	
	cout<<"El tiempo transcurrido fue: "<<((double)(end-start))/CLOCKS_PER_SEC<<endl;
	return 0;
}
