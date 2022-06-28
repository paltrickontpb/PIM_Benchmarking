#ifndef __COMMON_H__
#define __COMMON_H__

#define BUFFER_SIZE (8 << 20) // 8,388,608 Elements
#define DPU_COUNT 16

#define NR_ELEMENTS_PER_TASKLET (BUFFER_SIZE/NR_TASKLETS)
#define NR_ELEM_PER_DPU (BUFFER_SIZE/DPU_COUNT)

#endif