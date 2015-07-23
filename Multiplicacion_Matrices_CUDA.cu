//PROGRAMA QUE MULTIPLICA DOS MATRICES CUADRADAS EN CUDA
#include<iostream>
#include<stdio.h>
#include<malloc.h>
#include<cuda.h>
using namespace std; 


__global__ void MultiplicaMatricesCU(int* A,int* B,int* C,int m,int n){//matriz[m][n]
	int row = blockIdx.y*blockDim.y + threadIdx.y;
	int col = blockIdx.x*blockDim.x + threadIdx.x;
	int i=row*n+col;
	// ancho=n (columnas, o sea en x)
	if((row<m)&&(col<n)){
		int suma=0;
		for(int k=0;k<m;k++){//este es para que multiplique por las columnas 
			suma=suma+A[(row*n)+k]*B[(row*n)+k];
		}
		C[i]=suma;
	}	
}

void imprime(int* A,int filas, int columnas){//imprime como si fuera una matriz
	for(int i = 0; i < x; i++){
        	for(int j = 0; j < y; j++){
            		cout<<A[(i*x)+j];
        	}
        cout<<endl;
    }
}	

void inicializa(int *A,int filas, int columnas){//inicializa arreglos
	for(int i=0;i<x*y;i++){
		A[i]=1;
	}
}

int main(void){
	clock_t start, end;//para contar el tiempo de ejecución del programa
	int x=2048,y=2048,SIZE=x*y;//dimensiones de la matriz	x = columnas, y = filas
	int *d_A,*d_B,*d_C,*A,*B,*C;
	
	//reservamos memoria en el host
	A=(int*)malloc(SIZE*sizeof(int));//matriz cuadrada
	B=(int*)malloc(SIZE*sizeof(int));
	C=(int*)malloc(SIZE*sizeof(int));

	//inicializa las matrices A y B
	inicializa(A,y,x);
	inicializa(B,y,x);

	//iniciamos la cuenta del reloj
	start = clock();

	//reservamos memoria en el device
	cudaMalloc((void**)&d_A,SIZE*sizeof(int));
	cudaMalloc((void**)&d_B,SIZE*sizeof(int));
	cudaMalloc((void**)&d_C,SIZE*sizeof(int));
	
	//copiamos del host al device
	cudaMemcpy(d_A,A,SIZE*sizeof(int),cudaMemcpyHostToDevice);//destino d_A y origen A
	cudaMemcpy(d_B,B,SIZE*sizeof(int),cudaMemcpyHostToDevice);

	dim3 dimblock(32,32,1);//dimensión de los bloques(cantidad de hilos que se van a utilizar)
	dim3 dimGrid(ceil(x/32),ceil(y/32),1);//dimensión de la malla (cantidad de bloques que se van a utilizar)
	
	MultiplicaMatricesCU<<<dimGrid,dimblock>>>(d_A,d_B,d_C,y,x);//enviamos x y y porque son las dimensiones de la matriz y se deben enviar para no utilizar más hilos o bloques de los necesarios

	cudaDeviceSynchronize();//esperamos a que termine la función anterior

	cudaMemcpy(C,d_C,SIZE*sizeof(int),cudaMemcpyDeviceToHost);

	//terminamos la cuenta del reloj
	end = clock();

	imprime(C,y,x);//mostramos el resultado

	cout<<endl;

	cout<<"El tiempo transcurrido fue: "<<((double)(end-start))/CLOCKS_PER_SEC<<endl;	

	//liberamos memoria tanto la utilizada en el host como la del device
	free(A);free(B);free(C);
	cudaFree(d_A);
	cudaFree(d_B);
	cudaFree(d_C);	
	
	return 0;
}

