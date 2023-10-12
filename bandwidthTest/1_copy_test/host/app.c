#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <dpu.h>
#include <dpu_log.h>
#include <unistd.h>
#include <getopt.h>
#include <assert.h>

#define DPU_BINARY "../dpu/dpu"

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

// Other helper functions
static void init_array(uint64_t *buffer, int bufsize) {
    // Read from from the dataset or set a random buffer
    srand(0);
    for (int i=0; i<bufsize; i++) {
        buffer[i] = rand();
    }
}

// Free the input and output buffers
static void free_buffers(uint64_t *input_array, uint64_t *out_array) {
    free(input_array);
    free(out_array);
}

// Allocate memory to the bufffers
static void alloc_buffers(uint64_t **input_array, uint64_t nr_dpus){
    *input_array = malloc(sizeof(uint64_t) * NR_ELEM_PER_DPU * nr_dpus);
    init_array(*input_array, NR_ELEM_PER_DPU * nr_dpus);
}

static void free_dpus(struct dpu_set_t set) {
    DPU_ASSERT(dpu_free(set));
}


int main(void){

    struct dpu_set_t set, dpu;
    uint32_t nr_dpus, each_dpu;

    // Allocate DPUs and load binary
    DPU_ASSERT(dpu_alloc(NR_DPUS, NULL, &set));
    DPU_ASSERT(dpu_load(set, DPU_BINARY, NULL));

    DPU_ASSERT(dpu_get_nr_dpus(set, &nr_dpus));
    printf("Allocated %d DPU(s)\n", nr_dpus);

    uint64_t *input_array;
    uint64_t *outCycles = malloc(sizeof(uint64_t) * nr_dpus);
    alloc_buffers(&input_array, nr_dpus);

    // Copy input array to DPU
    DPU_FOREACH(set, dpu, each_dpu){
        DPU_ASSERT(dpu_prepare_xfer(dpu, &input_array[each_dpu * NR_ELEM_PER_DPU])); //DPU, First element address
    }
    DPU_ASSERT(dpu_push_xfer(set, DPU_XFER_TO_DPU, "buffer", 0, sizeof(uint64_t) * NR_ELEM_PER_DPU, DPU_XFER_DEFAULT));

    begin_dpu = now();
    // Run DPUs
    DPU_ASSERT(dpu_launch(set, DPU_SYNCHRONOUS));

    DPU_FOREACH(set, dpu, each_dpu){
        if(each_dpu==0) DPU_ASSERT(dpu_log_read(dpu, stdout));
    }

    // Copy output from dpus
    DPU_FOREACH(set, dpu, each_dpu){
        DPU_ASSERT(dpu_prepare_xfer(dpu, &outCycles[each_dpu]));
    }
    DPU_ASSERT(dpu_push_xfer(set, DPU_XFER_FROM_DPU, "cycles", 0, sizeof(uint64_t), DPU_XFER_DEFAULT));

    end_dpu = now();
    time_spent_dpu = tdiff(begin_dpu, end_dpu);

    printf("Total Time Spent by DPU: %.8f sec\n", time_spent_dpu);

    // Free the memories
    free_buffers(input_array, outCycles);
    free_dpus(set);

    return 0;
}