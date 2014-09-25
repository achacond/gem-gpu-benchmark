#!/bin/bash

if [[ -n $(hostname | grep aopccuda) ]]; then
	echo "Aopccuda Node"
	source /etc/profile.d/module.sh
	module load CUDA/6.5.14
	num_threads="8"
fi

if [[ -n $(hostname | grep huberman) ]]; then
	echo "Huberman Node"
	module load cuda/6.5
	num_threads="32"
fi

IN=$1
OUT_PREFIX=$IN

#Changing working directory
original_path=`pwd`
mapper_path="../../software/mappers/gem-gpu"
cd $mapper_path

index_path="../../../data/indexes"
dataset_path="../../../data/datasets"
results_path="../../../data/results"
log_path="../../../logs"


# Warm up
################################################################

OUT="$OUT_PREFIX.warm.t$num_threads"
time bin/gem-mapper -t $num_threads -v --stats -I $index_path/HG_index_BWA_default/hsapiens_v37.gem -i $dataset_path/$IN.fastq -o $results_path/$OUT.sam > $log_path/$OUT.out 2> $log_path/$OUT.err


# Test multi-threading
################################################################

OUT="$OUT_PREFIX.t$num_threads"
time bin/gem-mapper -t $num_threads -v --stats -I $index_path/HG_index_BWA_default/hsapiens_v37.gem -i $dataset_path/$IN.fastq -o $results_path/$OUT.sam > $log_path/$OUT.out 2> $log_path/$OUT.err

#Returning to original path
cd $original_path