#include<iostream>
#include<cuda.h>
using namespace std;

__global__ void use_shared_memory_GPU(float *array){

	//local variables, private to each thread
	int i,index=threadIdx.x;
	float average,sum=0.0f;

	//__shared__ variables are visible to all threads in the thread block
	//and have the same lifetime as the thread block

	__shared__ float sh_arr[128];

	//copy data from "array" in global memory to sh_arr in shared memory
	//here, each thread is responsable for copying a single element
	sh_arr[index]=array[index];

	__syncthreads(); //ensure all the writes to shares memory have completed

	//now, sh_arr is fully populated. Let's find the average of all previous elements
	for(i=0;i<index;i++) sum+=sh_arr[index];
	average=sum/(index+1.0f);

	//if array[index] is greater than the average of array[0..index-1], replace with average.
	//since array[] is in global memory, this change will be seen by the host (and potentially
	//other thread blocks, if any)
	if(array[index]>average) array[index]=average;

	//the following code has NO EFFECT: it modifies shared memory but,
	//the resulting modified data is never copied back to global memory
	sh_arr[index]=3.14;
}

int main(void){
	
	/*
		.
		.
		.
	*/

	use_shared_memory_GPU<<<1,128>>>(2.0f);
	
	//next, call a kernel taht shows using global memory

	float h_array[128];
	float *d_arr;

	cudaMalloc((void **)&d_arr,sizeof(float)*128);
	cudaMemcpy((void *)d_arr,(void *)h_arr,sizeof(float)*128,cudaMemcpyHostToDevice);
	use_shared_memory_GPU<<<1,128>>>(d_arr);//modifies the contents of array at d_arr
	cudaMemcpy((void *)h_arr,(void *)d_arr,sizeof(float)*128,cudaMemcpyDeviceToHost);

	//next, call a kernel that shows using shared memory

	//as before, pass in a pointer to data in global memory
	use_shared_memory_GPU<<<1,128>>(d_arr);
	cudaMemcpy((void *)h_arr,(void *)d_arr,sizeof(float)*128,cudaMemcpyHostToDevice);

	return 0;
}