#include <stdio.h>
#include "cuda_sample.h"

__global__ void CudaHelloDevice() { printf("Hello World from GPU!\n"); }

void CudaHello() { CudaHelloDevice<<<1, 1>>>(); }
