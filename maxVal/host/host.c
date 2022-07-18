#include <stdio.h>
#include <stdlib.h>
#include <dpu.h>
#include <time.h>

#include "common.h"

#ifndef DPU_BINARY
#define DPU_BINARY "/home/protox/upmem/maxVal/build/dpu"
#endif
//-DDPU_BINARY='"/home/protox/upmem/maxVal/build/task"'

// Initialising execution time helper functions
typedef double ttype;
ttype tdiff(struct timespec a, struct timespec b)
/* Find the time difference. */
{
    ttype dt = ((b.tv_sec - a.tv_sec) + (b.tv_nsec - a.tv_nsec) / 1E9);
    return dt;
}

struct timespec now()
/* Return the current time. */
{
    struct timespec t;
    clock_gettime(CLOCK_REALTIME, &t);
    return t;
}

struct timespec begin, end, begin_dpu, end_dpu;
double time_spent_cpu, time_spent_dpu;
 
// Kernel
int computeMax(uint32_t *data, uint32_t nr_elem){
    uint32_t max = 0;
    for (uint32_t i=0; i<nr_elem; i++) if (max < data[i]) max = data[i];
    return max;
}

// Other helper functions
static void init_array(uint32_t *buffer, int bufsize) {
    // Read from from the dataset or set a random buffer
    srand(0);
    for (int i=0; i<bufsize; i++) {
        buffer[i] = rand();
    }
}

// Free the input and output buffers
static void free_buffers(uint32_t *input_array, uint32_t* output_array) {
    free(input_array);
    free(output_array);
}

// Allocate memory to the bufffers
static void alloc_buffers(uint32_t **input_array, uint32_t **output_array, uint32_t nr_dpus){
    *input_array = malloc(sizeof(uint32_t) * NR_ELEM_PER_DPU * nr_dpus);
    *output_array = malloc(sizeof(uint32_t) * nr_dpus);
    init_array(*input_array, NR_ELEM_PER_DPU * nr_dpus);
}

static void free_dpus(struct dpu_set_t set) {
    DPU_ASSERT(dpu_free(set));
}

int main(){
    struct dpu_set_t set, dpu;
    uint32_t nr_dpus, each_dpu;

    // Allocate DPUs and load binary
    DPU_ASSERT(dpu_alloc(DPU_COUNT, NULL, &set));
    DPU_ASSERT(dpu_load(set, DPU_BINARY, NULL));
    
    DPU_ASSERT(dpu_get_nr_dpus(set, &nr_dpus));
    printf("%d DPUs allocated\n", nr_dpus);

    // Set input and output buffers in the host
    uint32_t *input_array, *output_array;
    alloc_buffers(&input_array, &output_array, nr_dpus);

    // Copy input array to DPU
    DPU_FOREACH(set, dpu, each_dpu){
        DPU_ASSERT(dpu_prepare_xfer(dpu, &input_array[each_dpu * NR_ELEM_PER_DPU])); //DPU, First element address
    }
    DPU_ASSERT(dpu_push_xfer(set, DPU_XFER_TO_DPU, "buffer", 0, sizeof(uint32_t) * NR_ELEM_PER_DPU, DPU_XFER_DEFAULT));

    begin_dpu = now();
    // Run DPUs
    DPU_ASSERT(dpu_launch(set, DPU_SYNCHRONOUS));

    DPU_FOREACH(set, dpu, each_dpu){
        if(each_dpu==0) DPU_ASSERT(dpu_log_read(dpu, stdout));
    }

    // Copy output from dpus
    DPU_FOREACH(set, dpu, each_dpu){
        DPU_ASSERT(dpu_prepare_xfer(dpu, &output_array[each_dpu]));
    }
    DPU_ASSERT(dpu_push_xfer(set, DPU_XFER_FROM_DPU, "maxval", 0, sizeof(uint32_t), DPU_XFER_DEFAULT));

    // Output verification
    uint32_t dpu_max = computeMax(output_array, DPU_COUNT);
    end_dpu = now();
    time_spent_dpu = tdiff(begin_dpu, end_dpu);

    begin = now();
    uint32_t expected_max = computeMax(input_array, BUFFER_SIZE);
    end = now();
    time_spent_cpu = tdiff(begin, end);

    printf("Expected: 0x%x\nReceived: 0x%x\n", expected_max, dpu_max);

    if (expected_max == dpu_max){
        printf("Correct Output!\n");
    } else {
        printf("Incorrect Output!\n");
    }

    printf("Total Time Spent by DPU: %.8f sec\n", time_spent_dpu);
    printf("Total Time Spent by CPU: %.8f sec\n", time_spent_cpu);

    // Free the memories
    free_buffers(input_array, output_array);
    free_dpus(set);

    return 0;
}

