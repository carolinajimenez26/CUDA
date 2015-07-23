//PROGRAMA QUE SUMA DOS MATRICES EN CUDA
#include<iostream>
#include<stdio.h>
#include<malloc.h>
#include<cuda.h>
using namespace std; 


__global__ void SumaMatricesCU(int* A,int* B,int* C,int m,int n){//matriz[m][n]
	int row = blockIdx.y*blockDim.y + threadIdx.y;
	int col = blockIdx.x*blockDim.x + threadIdx.x;
	int i=row*n+col; //filas*ancho+columnas, el ancho son las columnas que tiene la matriz (eje x)
	if((row<m)&&(col<n)){
		C[i]=A[i]+B[i];
	}	
}

void imprime(int* A,int x, int y){
	for(int i = 0; i < x; i++){
        for(int j = 0; j < y; j++){
            cout<<A[(i*x)+j];
        }
        cout<<endl;
    }
}	

int main(void){
	clock_t start, end;
	int x=2048,y=2048,SIZE=x*y;//dimensiones de la matriz	x = columnas, y = filas
	int *d_A,*d_B,*d_C,*A,*B,*C;

	//reservamos memoria para el host
	A=(int*)malloc(SIZE*sizeof(int));//matriz cuadrada
	B=(int*)malloc(SIZE*sizeof(int));
	C=(int*)malloc(SIZE*sizeof(int));

	//inicializa las matrices A y B
	for(int i=0;i<SIZE;i++){
			A[i]=1;
			B[i]=1;
	}

	//iniciamos la cuenta del reloj
	start = clock();

	//reservamos memoria para el device
	cudaMalloc((void**)&d_A,SIZE*sizeof(int));
	cudaMalloc((void**)&d_B,SIZE*sizeof(int));
	cudaMalloc((void**)&d_C,SIZE*sizeof(int));
	
	//copiamos del host al device
	cudaMemcpy(d_A,A,SIZE*sizeof(int),cudaMemcpyHostToDevice);//destino d_A y origen A
	cudaMemcpy(d_B,B,SIZE*sizeof(int),cudaMemcpyHostToDevice);

	dim3 dimblock(32,32,1);//dimensión de los bloques(cantidad de hilos que se van a utilizar)
	dim3 dimGrid(ceil(x/32),ceil(y/32),1);//dimensión de la malla (cantidad de bloques que se van a utilizar)
	
	SumaMatricesCU<<<dimGrid,dimblock>>>(d_A,d_B,d_C,y,x);//enviamos x y y porque son las dimensiones de la matriz y son menos 
	//de los hilos que se van a utilizar

	cudaDeviceSynchronize();

	cudaMemcpy(C,d_C,SIZE*sizeof(int),cudaMemcpyDeviceToHost);
	
	//terminamos la cuenta del reloj
	end = clock();

	imprime(C,x,y);

	cout<<endl;
	cout<<"El tiempo transcurrido fue: "<<((double)(end-start))/CLOCKS_PER_SEC<<endl;

	free(A);free(B);free(C);
	cudaFree(d_A);
	cudaFree(d_B);
	cudaFree(d_C);	
	
	return 0;
}

