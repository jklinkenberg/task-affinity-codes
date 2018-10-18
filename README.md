# Benchmark collection to test task affinity implementation presented during IWOMP 2018

## 1. List of benchmarks tested
The following benchmarks have been tested with and without affinity extenstion for the OpenMP task construct.

* **./stream**                  
    - STREAM version that uses tasks instead of work sharing construct
* **./bots/omp-tasks/sort**     
    - Parallel merge sort algorithm from bots benchmark suite
* **./bots/omp-tasks/health**   
    - health benchmark from bots benchmark suite
* **./sparse_CG/tasking**       
    - CG solver that uses SPMXV

## 2. How to compile and run

#### 2.1 Clone repository that contains the customized runtime and switch to branch **task-affinity**  
```
git clone git@github.com:jklinkenberg/openmp.git
cd openmp  
git checkout task-affinity  
```

#### 2.2 Move back to folder that contains **openmp** repo and clone this repository now  
```
cd ..
git clone git@github.com:jklinkenberg/task-affinity-codes.git
cd task-affinity-codes
```

#### 2.3 Set the following environment variables. Then build the runtime  
```
export RUNTIME_AFF_REL_DIR=$(pwd)/runtime_affinity_rel
export RUNTIME_AFF_DEB_DIR=$(pwd)/runtime_affinity_deb
make
```

#### 2.4 Set your C compiler either to intel or clang (Should be a compiler that is compatible with LLVM OpenMP runtime)  
```
export CC=icc
```

#### 2.5 Move to desired benchmark folder, e.g., stream and execute fast run, that will compare llvm basline with affinity versions  
```
cd stream
sh fast_run.sh
```
