#!/bin/bash

PROG_CMD="./health.exe -f ../../inputs/health/large.input_rwth"
#PROG_VERSION=deb
PROG_VERSION=rel

export KMP_TASK_STEALING_CONSTRAINT=0 # needs to be disabled at the moment
export OMP_PLACES=cores 
export OMP_PROC_BIND=spread 
export OMP_NUM_THREADS=8

function eval_run {
  curname=$1
  if ! [ -z "$2" ]; then
    curname="${curname}.$2"
  fi
  echo "Executing affinity ${curname}"
  make ${PROG_VERSION}."$1"

  # make sure to disable NUMA balancer (if available on your system)
  # we had a script for that on our systems called "no_numa_balancing"
  # no_numa_balancing ${PROG_CMD} &> output_${curname}.txt
  ${PROG_CMD} &> output_${curname}.txt

  grep "Elapsed time" output_${curname}.txt
}

# clean first
make clean

# make sure custom llvm library will be executed (set explicitly or use module system)
export LD_LIBRARY_PATH=${RUNTIME_AFF_REL_DIR}/lib:${LD_LIBRARY_PATH}
export LIBRARY_PATH=${RUNTIME_AFF_REL_DIR}/lib:${LIBRARY_PATH}

export INCLUDE=${RUNTIME_AFF_REL_DIR}/include:${INCLUDE}
export CPATH=${RUNTIME_AFF_REL_DIR}/include:${CPATH}
export C_INCLUDE_PATH=${RUNTIME_AFF_REL_DIR}/include:${C_INCLUDE_PATH}
export CPLUS_INCLUDE_PATH=${RUNTIME_AFF_REL_DIR}/include:${CPLUS_INCLUDE_PATH}

# execute tests with and without affinity
eval_run "llvm"
eval_run "domain.lowest"
#eval_run "domain.rand"
#eval_run "domain.round_robin"
eval_run "thread.lowest"
#eval_run "thread.rand"
#eval_run "thread.round_robin"



