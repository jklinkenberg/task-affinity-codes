# How to compile and run task affinity tests

#### 1. Clone repository that contains the customized runtime and switch to branch **task-affinity**  
```
git clone git@github.com:jklinkenberg/openmp.git
cd openmp  
git checkout task-affinity  
```

#### 2. Move back to folder that contains **openmp** repo and clone this repository now  
```
cd ..
git clone git@github.com:jklinkenberg/task-affinity-codes.git
cd task-affinity-codes
```

#### 3. Set the following environment variables. Then build the runtime  
```
export RUNTIME_AFF_REL_DIR=$(pwd)/runtime_affinity_rel
export RUNTIME_AFF_DEB_DIR=$(pwd)/runtime_affinity_deb
make
```

#### 4. Set your C compiler either to intel or clang (Should be a compiler that is compatible with LLVM OpenMP runtime)  
```
export CC=icc
```

#### 5. Move to desired benchmark folder, e.g., stream and execute fast run, that will compare llvm basline with affinity versions  
```
cd stream
sh fast_run.sh
```

#### Remark: The other codes will follow soon
