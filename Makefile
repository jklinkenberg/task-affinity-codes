MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
CUR_DIR := $(dir $(MKFILE_PATH))
RUNTIME_DIR?=${CUR_DIR}../openmp/runtime
BUILD_DIR=$(RUNTIME_DIR)/build
#CUR_COMPILER_OPTS=-DCMAKE_C_COMPILER=icc -DCMAKE_CXX_COMPILER=icpc -DCMAKE_Fortran_COMPILER=ifort
CUR_COMPILER_OPTS=

# directories for final runtime
RUNTIME_AFF_REL_DIR ?= ${CUR_DIR}runtime_affinity_rel
RUNTIME_AFF_DEB_DIR ?= ${CUR_DIR}runtime_affinity_deb

all: task.deb task.rel

all_begin:
	mkdir -p $(BUILD_DIR)

	mkdir -p $(RUNTIME_AFF_REL_DIR)/include
	mkdir -p $(RUNTIME_AFF_REL_DIR)/lib
	
	mkdir -p $(RUNTIME_AFF_DEB_DIR)/include
	mkdir -p $(RUNTIME_AFF_DEB_DIR)/lib

task.deb: all_begin
	cmake -H"$(RUNTIME_DIR)" ${CUR_COMPILER_OPTS} -DCMAKE_BUILD_TYPE=debug -DLIBOMP_FORTRAN_MODULES=ON -DLIBOMP_USE_STDCPPLIB=ON -DLIBOMP_OMPT_SUPPORT=ON -DLIBOMP_USE_TASK_AFFINITY=ON -B"$(BUILD_DIR)" 
	make -C $(BUILD_DIR) rebuild_cache -j4
	make -C $(BUILD_DIR) -j4
	
	cp -v $(BUILD_DIR)/src/lib* $(RUNTIME_AFF_DEB_DIR)/lib/
	cp -v $(BUILD_DIR)/src/omp* $(RUNTIME_AFF_DEB_DIR)/include/

task.rel: all_begin
	cmake -H"$(RUNTIME_DIR)" ${CUR_COMPILER_OPTS} -DCMAKE_BUILD_TYPE=release -DLIBOMP_FORTRAN_MODULES=ON -DLIBOMP_USE_STDCPPLIB=ON -DLIBOMP_OMPT_SUPPORT=ON -DLIBOMP_USE_TASK_AFFINITY=ON -B"$(BUILD_DIR)" 
	make -C $(BUILD_DIR) rebuild_cache -j4
	make -C $(BUILD_DIR) -j4
	
	cp -v $(BUILD_DIR)/src/lib* $(RUNTIME_AFF_REL_DIR)/lib/
	cp -v $(BUILD_DIR)/src/omp* $(RUNTIME_AFF_REL_DIR)/include/
