#include<iostream>
#include<stdlib.h>
#include<time.h>
#include<cassert>

using namespace std;

void llenaMatrices(int** X,int filas, int columnas){
	srand(time(NULL));
	for (int i = 0; i < filas; i++){
			for(int j=0;j<columnas;j++){
				X[i][j]=rand()%10;
			}
	}
	//return X;	
}

void imprimeMatrices(int** X,int filas,int columnas){
	for (int i = 0; i < filas; i++){
			for(int j=0;j<columnas;j++){
				cout<<X[i][j]<<" ";
			}
			cout<<endl;
	}
}

void inicializaMatriz(int** X,int filas, int columnas){//la llena de ceros
	for(int i=0;i<filas;i++){
		for(int j=0;j<columnas;j++){
			X[i][j]=0;
		}
	}
	//return X;
}

/*
int** multiplicaMatrices(int** X,int filX,int colX,int** Y,int filY,int colY,int** Z){
	int suma=0;
	assert(colX==filY);//las columnas de la primera matriz deben ser iguales a las filas de la segunda matriz
	//Z=inicializaMatriz(Z,filX,colY);
	for(int i=0;i<filX;i++){//la multiplicación se realiza entre las filas de la primera matriz
		for(int j=0;j<colY;j++){//y las columnas de la segunda matriz
			suma=0;//reiniciamos una vez puesto el valor correspondiente en la matriz Z
			for(int k=0;k<filY;k++){
				suma=suma+X[i][k]*Y[k][j];
			}
			Z[i][j]=suma;//este es el valor de la multiplicación
		}	
	}
	return Z;
}*/

int main(void){
	
	int**A;//*int** B;int** C;//Matrices
	//A[filA][colA], B[filB][colB], C[filA][colB]
	int filA,filB,colA,colB;
	
	A=(int**)malloc(filA*sizeof(int*));//reservamos memoria


cout<<"cali y caro for ever";cout<<"cali y caro for ever";cout<<"cali y caro for ever";cout<<"cali y caro for ever";
	//for(int i=0;i<filA;i++){
	//	A[i]=(int*)malloc(colA*sizeof(int*));
	//}


	
	/*B=(int**)malloc(filB*sizeof(int*));//reservamos memoria
	for(int i=0;i<filB;i++){
		B[i]=(int*)malloc(colB*sizeof(int*));
	}
	
	C=(int**)malloc(filA*sizeof(int*));//reservamos memoria
	for(int i=0;i<filA;i++){
		C[i]=(int*)malloc(colB*sizeof(int*));
	}*/
	
cout<<"cali y caro for ever";

//inicializaMatriz(A,filA,colA);
	//imprimeMatrices(A,filA,colA);
	//llenaMatrices(A,filA,colA);
	//B=llenaMatrices(B,filB,colB);

	
	/*imprimeMatrices(B,filB,colB);

	C=multiplicaMatrices(A,filA,colA,B,filB,colB,C);
	imprimeMatrices(C,filA,colB);*/

	//free(*A);//free(*B);free(*C);
	//free(A);//free(B);free(C);

	return 0;
	
}
