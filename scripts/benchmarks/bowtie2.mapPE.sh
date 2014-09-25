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
mapper_path="../../software/mappers/bowtie2-2.2.3"
cd $mapper_path

index_path="../../../data/indexes"
dataset_path="../../../data/datasets"
results_path="../../../data/results"
log_path="../../../logs"



# Warm up
################################################################
OUT="$OUT_PREFIX.warm.t1"
time ./bowtie2 -X 1000 -x $index_path/HG_index_bowtie2_default/hsapiens -1 $dataset_path/$IN.1.fastq -2 $dataset_path/$IN.2.fastq -S $results_path/$OUT.sam 2> $OUT.err > $OUT.out


# Test single-thread
################################################################

OUT="$OUT_PREFIX.very.fast.t1"
time ./bowtie2 --very-fast -X 1000 -x $index_path/HG_index_bowtie2_default/hsapiens -1 $dataset_path/$IN.1.fastq -2 $dataset_path/$IN.2.fastq -S $results_path/$OUT.sam 2> $log_path/$OUT.err > $log_path/$OUT.out
OUT="$OUT_PREFIX.default.t1"
time ./bowtie2             -X 1000 -x $index_path/HG_index_bowtie2_default/hsapiens -1 $dataset_path/$IN.1.fastq -2 $dataset_path/$IN.2.fastq -S $results_path/$OUT.sam 2> $log_path/$OUT.err > $log_path/$OUT.out
OUT="$OUT_PREFIX.very.sensitive.t1"
time ./bowtie2 --very-sensitive -X 1000 -x $index_path/HG_index_bowtie2_default/hsapiens -1 $dataset_path/$IN.1.fastq -2 $dataset_path/$IN.2.fastq -S $results_path/$OUT.sam 2> $log_path/$OUT.err > $log_path/$OUT.out


# Test multi-threading
################################################################

OUT="$OUT_PREFIX.very.fast.t$num_threads"
time ./bowtie2 --threads $num_threads --very-fast -X 1000 -x $index_path/HG_index_bowtie2_default/hsapiens -1 $dataset_path/$IN.1.fastq -2 $dataset_path/$IN.2.fastq -S $results_path/$OUT.sam 2> $log_path/$OUT.err > $log_path/$OUT.out
OUT="$OUT_PREFIX.default.t$num_threads"
time ./bowtie2 --threads $num_threads -X 1000 -x $index_path/HG_index_bowtie2_default/hsapiens -1 $dataset_path/$IN.1.fastq -2 $dataset_path/$IN.2.fastq -S $results_path/$OUT.sam 2> $log_path/$OUT.err > $log_path/$OUT.out
OUT="$OUT_PREFIX.very.sensitive.t$num_threads"
time ./bowtie2 --threads $num_threads --very-sensitive -X 1000 -x $index_path/HG_index_bowtie2_default/hsapiens -1 $dataset_path/$IN.1.fastq -2 $dataset_path/$IN.2.fastq -S $results_path/$OUT.sam 2> $log_path/$OUT.err > $log_path/$OUT.out

#Returning to original path
cd $original_path
