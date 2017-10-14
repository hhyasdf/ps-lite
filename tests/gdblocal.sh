#!/bin/bash
# set -x
if [ $# -lt 3 ]; then
    echo "usage: $0 num_servers num_workers bin [args..]"
    exit -1;
fi

export DMLC_NUM_SERVER=$1
shift
export DMLC_NUM_WORKER=$1
shift
bin=$1
shift
arg="$@"

#echo ${arg}

# start the scheduler
export DMLC_LOCAL=0
export DMLC_PS_ROOT_URI='10.10.3.6'
export DMLC_PS_ROOT_PORT=13542
export DMLC_INTERFACE='ib0'
export DMLC_ROLE='scheduler'
#${bin} ${arg} &
gdb ${bin} -x gdb.txt &

sleep 3

# start servers
export DMLC_ROLE='server'
for ((i=0; i<${DMLC_NUM_SERVER}; ++i)); do
    export HEAPPROFILE=./S${i}
#    ${bin} ${arg} &
    gdb ${bin} -x gdb.txt &
done

# start workers
export DMLC_ROLE='worker'
for ((i=0; i<${DMLC_NUM_WORKER}; ++i)); do
    export HEAPPROFILE=./W${i}
#    ${bin} ${arg} &
    gdb ${bin} -x gdb.txt &
done

wait
