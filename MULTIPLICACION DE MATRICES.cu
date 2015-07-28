//MULTIPLICACIÓN DE MATRICES(APLANADAS) EN C++ y CUDA con tiempo
#include<iostream>
#include<stdio.h>
#include<malloc.h>
#include<cuda.h>
using namespace std; 


__global__ void MultiplicaMatricesCU(int* A,int* B,int* C,int filA,int colA,int filB,int colB){
	int row = blockIdx.y*blockDim.y + threadIdx.y;
	int col = blockIdx.x*blockDim.x + threadIdx.x;
	// ancho=n (columnas, o sea en x)
	if((row<filA)&&(col<colB)){//C[filA][colB]
		int suma=0;
		for(int k=0;k<filB;k++){//Se mueve entre las filas de B 
			suma=suma+A[(row*colA)+k]*B[(row*filB)+k];
		}
		C[(row*colB)+col]=suma;
	}	
}

__host__ void multiplicaMatrices(int* X,int filX,int colX,int* Y,int filY,int colY,int* Z){
	for(int i=0;i<filX;i++){
		for(int j=0;j<colY;j++){
			int suma=0;
			for(int k=0;k<filY;k++){
				suma=suma+X[(i*colX)+k]*Y[(k*filY)+j];
			}
			Z[(i*colY)+j]=suma;
		}	
	}
}

__host__ void imprime(int* A,int filas, int columnas){//imprime como si fuera una matriz
	for(int i = 0; i < filas; i++){
        	for(int j = 0; j < columnas; j++){
            		cout<<A[(i*columnas)+j]<<" ";
        	}
        cout<<endl;
    }
}	

__host__ void inicializa(int *A,int filas, int columnas){//inicializa arreglos
	for(int i=0;i<filas*columnas;i++){
		A[i]=1;
	}
}

int main(void){

	clock_t startCPU,endCPU,startGPU,endGPU;  
	int *A,*B,*C; //A[filA][colA],B[filB][colB],C[filA][colB]
	int *d_A,*d_B,*d_C,*h_C;
	int filA=2,colA=2,filB=2,colB=4;
	
	//-------------------------------CPU--------------------------------------------------------------------
	startCPU = clock();	

	A=(int*)malloc(filA*colA*sizeof(int)); 
	B=(int*)malloc(filB*colB*sizeof(int));
	C=(int*)malloc(filA*colB*sizeof(int));

	inicializa(A,filA,colA);
	inicializa(B,filB,colB);
	
	if(colA==filB){//para que sean multiplicables
		multiplicaMatrices(A,filA,colA,B,filB,colB,C);
		imprime(C,filA,colB);
	}else{
		cout<<"Error, no se pueden multiplicar"<<endl;
	}
	
	endCPU = clock();

	double time_CPU=((double)(endCPU-startCPU))/CLOCKS_PER_SEC;
	cout<<"El tiempo transcurrido en la CPU fue: "<<time_CPU<<endl;
	//-------------------------------GPU--------------------------------------------------------------------
	h_C=(int*)malloc(filA*colB*sizeof(int));

	startGPU = clock();

	cudaMalloc((void**)&d_A,filA*colA*sizeof(int));
	cudaMalloc((void**)&d_B,filB*colB*sizeof(int));
	cudaMalloc((void**)&d_C,filA*colB*sizeof(int));	
	
	//Depende directamente de la dimensión de las matrices
	dim3 dimblock(3,3,1);
	dim3 dimGrid(1,1,1);
	
	MultiplicaMatricesCU<<<dimGrid,dimblock>>>(d_A,d_B,d_C,filA,colA,filB,colB);

	cudaDeviceSynchronize();

	cudaMemcpy(h_C,d_C,filA*colB*sizeof(int),cudaMemcpyDeviceToHost);
	
	endGPU = clock();

	imprime(h_C,filA,colB);
	double time_GPU=((double)(endGPU-startGPU))/CLOCKS_PER_SEC;
	cout<<"El tiempo transcurrido en la GPU fue: "<<time_GPU<<endl;
	//-----------------------------------------------------------------------------------
	cout<<"El tiempo de aceleramiento fue: "<<time_CPU/time_GPU<<endl;
	free(A);free(B);free(C);free(h_C);
	cudaFree(d_A);
	cudaFree(d_B);
	cudaFree(d_C);
	return 0;
}

