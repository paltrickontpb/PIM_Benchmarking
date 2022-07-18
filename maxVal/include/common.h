#ifndef __COMMON_H__
#define __COMMON_H__

#define BUFFER_SIZE (8 << 20) // 8,388,608 Elements => which is about 32Mb of data

#ifndef DPU_COUNT
#define DPU_COUNT 64
#endif

#define NR_ELEM_PER_DPU (BUFFER_SIZE/DPU_COUNT)
#define NR_ELEMENTS_PER_TASKLET (NR_ELEM_PER_DPU/NR_TASKLETS)

#endif