#include <stdint.h>
#include <stdio.h>
#include <defs.h>
#include <mram.h>
#include <alloc.h>
#include <perfcounter.h>
#include <barrier.h>

#define DATASIZE 704
#define CACHE_SIZE 32
#define NR_ELEMENTS_PER_TASKLET 64

// MRAM variables
__mram uint64_t buffer[DATASIZE];
__host uint64_t cycles;

__dma_aligned uint64_t cache[NR_TASKLETS][CACHE_SIZE];

// Barrier
BARRIER_INIT(my_barrier, NR_TASKLETS);

int main(void){
    uint64_t a=0;

    // Tasklet ID Init
    unsigned int tasklet_id = me();

    // Cycle Counter Init
    if (tasklet_id==0){
        mem_reset();
        perfcounter_config(COUNT_CYCLES, true);
    }
    perfcounter_t start_time, end_time;

    barrier_wait(&my_barrier);

    // Data movement Start
    for(uint64_t i=tasklet_id*NR_ELEMENTS_PER_TASKLET; i<(tasklet_id+1)*NR_ELEMENTS_PER_TASKLET; i+=CACHE_SIZE){
        // MRAM TO SRAM [DMA_ALIGNED]
        start_time = perfcounter_get();
        mram_read(&buffer[i], &cache[tasklet_id][0], sizeof(uint64_t)*CACHE_SIZE);

        // SRAM to DPU
        //start_time = perfcounter_get();
        for(uint32_t j=0; j<CACHE_SIZE; j++) a = cache[tasklet_id][j];
        end_time = perfcounter_get();
        cycles += end_time - start_time;
        
    }
    barrier_wait(&my_barrier);
    printf("Total Number of Cycles Required: %lu", cycles);
    return 0;
}