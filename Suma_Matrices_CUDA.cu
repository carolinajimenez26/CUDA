//PROGRAMA QUE SUMA DOS MATRICES EN C++
#include<iostream>
#include<malloc.h>
#include<cuda.h>
using namespace std; 


__global__ void SumaMatricesCU(int** A,int** B,int** C,int x,int y){
	int idx=blockIdx.x*blockDim.x + threadIdx.x;//columnas
	int idy=blockIdx.y*blockDim.y + threadIdx.y;//filas
	if((idx<x)&&(idy<y)){
		C[idx][idy]=A[idx][idy]+B[idx][idy];
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
	int **A,**B,**C,**d_A,**d_B,**d_C,x=2000,y=1500;
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

	cudaMalloc(&d_A,x*sizeof(int));
	for(int i=0;i<x;i++){
		cudaMalloc(&d_A[i],y*sizeof(int));
	}
	cudaMalloc(&d_B,x*sizeof(int));
	for(int i=0;i<x;i++){
		cudaMalloc(&d_B[i],y*sizeof(int));
	}
	cudaMalloc(&d_C,x*sizeof(int));
	for(int i=0;i<x;i++){
		cudaMalloc(&d_C[i],y*sizeof(int));
	}
	
	inicializaMatriz(A,x,y);
	inicializaMatriz(B,x,y);

	cudaMemcpy(&d_A,A,x*y*sizeof(int),cudaMemcpyHostToDevice);//destino d_A y origen A
	cudaMemcpy(&d_B,B,x*y*sizeof(int),cudaMemcpyHostToDevice);
	
	//47*63*1024=3032064  esta es la cantidad de hilos que vamos a utilizar para hacer la suma de las matrices
	//porque las matrices tienen una dimensión de 2000*1500=3000000 
	//32*32 = 1024 hilos en cada bloque
	//2000/32=63, 1500/32=47
	dim3 dimblock(32,32,1);//dimensión de los bloques(cantidad de hilos que se van a utilizar)
	dim3 dimGrid(ceil(x/32),ceil(y/32),1);//dimensión de la malla (cantidad de bloques que se van a utilizar)
	
	SumaMatricesCU<<<dimGrid,dimblock>>>(d_A,d_B,d_C,x,y);//enviamos x y y porque son las dimensiones de la matriz y son menos 
	//de los hilos que se van a utilizar

	cudaDeviceSynchronize();//espera que termine la funcion anterior 
	cudaMemcpy(C,d_C,x*y*sizeof(int),cudaMemcpyDeviceToHost);//copia la operacion relizada en el device al host en el vector C

	imprimeMatriz(C,x,y);
	
	free(*A);free(*B);free(*C);free(A);free(B);free(C);
	cudaFree(d_A);
	cudaFree(d_B);
	cudaFree(d_C);	
	
	
	return 0;

}

