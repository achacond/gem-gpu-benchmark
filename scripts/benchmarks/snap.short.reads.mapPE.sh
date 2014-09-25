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
mapper_path="../../software/mappers/snap-1.0beta.10-linux"
cd $mapper_path

index_path="../../../data/indexes"
dataset_path="../../../data/datasets"
results_path="../../../data/results"
log_path="../../../logs"



# Warm up
################################################################

OUT=$OUT_PREFIX.warm.t1
time ./snap paired $index_path/HG_index_SNAP_short_reads $dataset_path/$IN.1.fastq $dataset_path/$IN.2.fastq -t 1 -h 50 -H 500 -s 0 1000 -o $results_path/$OUT.sam > $log_path/$OUT.out 2> $log_path/$OUT.err


# Test single-thread
################################################################

OUT=$OUT_PREFIX.h50.t1
time ./snap paired $index_path/HG_index_SNAP_short_reads $dataset_path/$IN.1.fastq $dataset_path/$IN.2.fastq -t 1 -h 50 -H 500 -s 0 1000 -o $results_path/$OUT.sam > $log_path/$OUT.out 2> $log_path/$OUT.err
OUT=$OUT_PREFIX.h100.t1
time ./snap paired $index_path/HG_index_SNAP_short_reads $dataset_path/$IN.1.fastq $dataset_path/$IN.2.fastq -t 1 -h 100 -H 1000 -s 0 1000 -o $results_path/$OUT.sam > $log_path/$OUT.out 2> $log_path/$OUT.err
OUT=$OUT_PREFIX.h1000.t1
time ./snap paired $index_path/HG_index_SNAP_short_reads $dataset_path/$IN.1.fastq $dataset_path/$IN.2.fastq -t 1 -h 1000 -H 16000 -s 0 1000 -o $results_path/$OUT.sam > $log_path/$OUT.out 2> $log_path/$OUT.err
OUT=$OUT_PREFIX.h2000.t1
time ./snap paired $index_path/HG_index_SNAP_short_reads $dataset_path/$IN.1.fastq $dataset_path/$IN.2.fastq -t 1 -h 2000 -H 20000 -s 0 1000 -o $results_path/$OUT.sam > $log_path/$OUT.out 2> $log_path/$OUT.err



# Test multi-threading
################################################################

OUT="$OUT_PREFIX.h50.t$num_threads"
time ./snap paired $index_path/HG_index_SNAP_short_reads $dataset_path/$IN.1.fastq $dataset_path/$IN.2.fastq -t $num_threads -h 50 -H 500 -s 0 1000 -o $results_path/$OUT.sam > $log_path/$OUT.out 2> $log_path/$OUT.err
OUT="$OUT_PREFIX.h100.t$num_threads"
time ./snap paired $index_path/HG_index_SNAP_short_reads $dataset_path/$IN.1.fastq $dataset_path/$IN.2.fastq -t $num_threads -h 100 -H 1000 -s 0 1000 -o $results_path/$OUT.sam > $log_path/$OUT.out 2> $log_path/$OUT.err
OUT="$OUT_PREFIX.h1000.t$num_threads"
time ./snap paired $index_path/HG_index_SNAP_short_reads $dataset_path/$IN.1.fastq $dataset_path/$IN.2.fastq -t $num_threads -h 1000 -H 16000 -s 0 1000 -o $results_path/$OUT.sam > $log_path/$OUT.out 2> $log_path/$OUT.err
OUT="$OUT_PREFIX.h2000.t$num_threads"
time ./snap paired $index_path/HG_index_SNAP_short_reads $dataset_path/$IN.1.fastq $dataset_path/$IN.2.fastq -t $num_threads -h 2000 -H 20000 -s 0 1000 -o $results_path/$OUT.sam > $log_path/$OUT.out 2> $log_path/$OUT.err

#Returning to original path
cd $original_path


