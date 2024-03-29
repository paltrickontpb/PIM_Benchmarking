CC = clang
DPUCC = dpu-upmem-dpurte-clang
DPU_DIR := dpu
HOST_DIR := host
BUILDDIR ?= build
OUTDIR ?= outputs
NR_TASKLETS ?= 16
NR_DPU ?= 1

define conf_filename
	$(BUILDDIR)/.NR_DPUS_$(1)_NR_TASKLETS_$(2).conf
endef
CONF := $(call conf_filename,${NR_DPUS},${NR_TASKLETS})

HOST_TARGET := ${BUILDDIR}/host
DPU_TARGET := ${BUILDDIR}/dpu

COMMON_INCLUDES := include
HOST_SOURCES := $(wildcard ${HOST_DIR}/*.c)
DPU_SOURCES := $(wildcard ${DPU_DIR}/*.c)

.PHONY: all clean test
__dirs := $(shell mkdir -p ${BUILDDIR})

COMMON_FLAGS := -Wall -Wextra -Werror -g -I${COMMON_INCLUDES} -DDPU_COUNT=${NR_DPUS} -DNR_TASKLETS=${NR_TASKLETS}
HOST_FLAGS := ${COMMON_FLAGS} -std=gnu99 -O3 `dpu-pkg-config --cflags --libs dpu`
DPU_FLAGS := ${COMMON_FLAGS} -O2 

all: ${HOST_TARGET} ${DPU_TARGET}

${CONF}:
	$(RM) $(call conf_filename,*,*)
	touch ${CONF}

${HOST_TARGET}: ${HOST_SOURCES} ${COMMON_INCLUDES} ${CONF}
	$(CC) -o $@ ${HOST_SOURCES} ${HOST_FLAGS}

${DPU_TARGET}: ${DPU_SOURCES} ${COMMON_INCLUDES} ${CONF}
	${DPUCC} ${DPU_FLAGS} -o $@ ${DPU_SOURCES}

clean:
	$(RM) -r $(BUILDDIR)
	$(RM) -r $(OUTDIR)

test: ${HOST_TARGET} ${DPU_TARGET}
	./${HOST_TARGET}
