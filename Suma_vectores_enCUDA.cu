//SUMA DE VECTORES EN C+++
#include<iostream>
#include<stdlib.h>
#include<time.h>
#include<cuda.h>

using namespace std;

//#define SIZE 1024;//tamaño de los vectores
int SIZE=1024;

void inicializaVec(int* X){
	srand(time(NULL));
	for(int i=0;i<SIZE;i++){
                X[i]=rand()%10;
        }
} 

void imprimeVec(int* X){
        for(int i=0;i<SIZE;i++){
                cout<<X[i]<<" ";
        }
}

__global__ void SumaVecCU(int *A,int *B, int*C){
	int tid=threadIdx.x;
	if(tid<SIZE)
		C[tid]=A[tid]+B[tid];

}


int main(void){
	clock_t start = clock();  
	int *A, *B, *C, *d_A, *d_B, *d_C; //vectores a los cuales se le van a realizar las operaciones
	A=(int*)malloc(SIZE*sizeof(int)); 
	B=(int*)malloc(SIZE*sizeof(int));
	C=(int*)malloc(SIZE*sizeof(int));
	cudaMalloc(&d_A,SIZE*sizeof(int));
	cudaMalloc(&d_B,SIZE*sizeof(int));
	cudaMalloc(&d_C,SIZE*sizeof(int));

	cudaMemcpy(d_A,A,SIZE*sizeof(int),cudaMemcpyHostToDevice);//destino d_A y origen A
	cudaMemcpy(d_B,B,SIZE*sizeof(int),cudaMemcpyHostToDevice);

	inicializaVec(A);
	inicializaVec(B);

	dim3 dimblock(SIZE,1,1);//vamos a utilicar un bloque con size threads
	dim3 dimGrid(1,1,1);
	
	SumaVecCU<<<dimGrid,dimblock>>>(d_A,d_B,d_C);
	cudaDeviceSynchronize();//espera que termine la funcion anterior 
	cudaMemcpy(C,d_C,SIZE*sizeof(int),cudaMemcpyDeviceToHost);//copia la operacion relizada en el device al host en el vector C

	imprimeVec(C);
	
	cout<<endl<<"Tiempo transcurrido: "<<((double)clock() - start) / CLOCKS_PER_SEC<<endl;
	return 0;
}
