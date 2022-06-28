#include <stdio.h>
#include <perfcounter.h>

#include "common.h"

#include <mram.h>
#include <defs.h>
#include <barrier.h>

BARRIER_INIT(sync_barrier, NR_TASKLETS);

#define CACHE_SIZE 32

__mram uint32_t buffer[NR_ELEM_PER_DPU];
__host uint32_t maxval;

uint32_t local_maxvals[NR_TASKLETS] = {0};
__dma_aligned uint32_t cache[NR_TASKLETS][CACHE_SIZE];

int main(){
    if (me() == 0){
        perfcounter_config(COUNT_CYCLES, true);
    }
    barrier_wait(&sync_barrier);

    for (uint32_t i=me()*NR_ELEMENTS_PER_TASKLET; i<(me()+1) * NR_ELEMENTS_PER_TASKLET; i+= CACHE_SIZE) {
        mram_read(&buffer[i], &cache[me()][0], sizeof(uint32_t)*CACHE_SIZE);

        for (uint32_t cache_idx = 0; cache_idx < CACHE_SIZE; cache_idx++) {
            if (local_maxvals[me()] < cache[me()][cache_idx]) local_maxvals[me()] = cache[me()][cache_idx];
        }
    }

    if (me() == 0){
       for (uint32_t i=0; i<NR_TASKLETS; i++) if( maxval < local_maxvals[i]) maxval = local_maxvals[i];
       perfcounter_t end_time = perfcounter_get();
       printf("Max Value = %u\nNumber of Elements = %u\nCycles needed per element = %f\n", maxval, NR_ELEM_PER_DPU, (float)end_time/NR_ELEM_PER_DPU);
    }

    return 0;
}