#!/bin/bash

#SBATCH --job-name="BWA-SE"
#SBATCH --exclusive
#SBATCH -w huberman

#SBATCH --time=1:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --mail-type=ALL
#SBATCH --mail-user="alejandro.chacon@uab.es"

if [[ -n $(hostname | grep aopccuda) ]]; then
	source /etc/profile.d/module.sh
	module load GCC/4.9.1
	module load CUDA/6.5.14
	num_threads="8"
fi

if [[ -n $(hostname | grep huberman) ]]; then
	module load gcc/4.9.1
	module load cuda/6.5
	num_threads="32"
fi

IN=$1
OUT_PREFIX=$IN

#Changing working directory
original_path=`pwd`
mapper_path="../../software/mappers/bwa-0.7.10"
cd $mapper_path

index_path="../../../data/indexes"
dataset_path="../../../data/datasets"
results_path="../../../data/results"
log_path="../../../logs"

echo "> Benchmarks for BWA 0.7.10: $IN"

# Warm up
################################################################

OUT="BWA.$OUT_PREFIX.warm.t$num_threads"
echo "==> Mapping $OUT"
time ./bwa mem -t $num_threads $index_path/HG_index_BWA_default/hsapiens_v37.fa $dataset_path/$IN.fastq > $results_path/$OUT.sam 2> $log_path/$OUT.err

# Test multi-threading
################################################################
# Default -k [19]  and -c [10000]
# - Min seed length, matches shorter than (-k) will be missed
# - Discard MEMs with more than (-c) occurences 
#	  (insensitive parameter)
#################################################################

OUT="BWA.$OUT_PREFIX.t$num_threads"
echo "==> Mapping $OUT"
time ./bwa mem -t $num_threads $index_path/HG_index_BWA_default/hsapiens_v37.fa $dataset_path/$IN.fastq > $results_path/$OUT.sam 2> $log_path/$OUT.err

OUT="BWA.$OUT_PREFIX.c500.t$num_threads"
echo "==> Mapping $OUT"
time ./bwa mem -t $num_threads -c 500 $index_path/HG_index_BWA_default/hsapiens_v37.fa $dataset_path/$IN.fastq > $results_path/$OUT.sam 2> $log_path/$OUT.err

OUT="BWA.$OUT_PREFIX.c1000.t$num_threads"
echo "==> Mapping $OUT"
time ./bwa mem -t $num_threads -c 1000 $index_path/HG_index_BWA_default/hsapiens_v37.fa $dataset_path/$IN.fastq > $results_path/$OUT.sam 2> $log_path/$OUT.err

OUT="BWA.$OUT_PREFIX.c16000.t$num_threads"
echo "==> Mapping $OUT"
time ./bwa mem -t $num_threads -c 16000 $index_path/HG_index_BWA_default/hsapiens_v37.fa $dataset_path/$IN.fastq > $results_path/$OUT.sam 2> $log_path/$OUT.err

OUT="BWA.$OUT_PREFIX.c20000.k16.t$num_threads"
echo "==> Mapping $OUT"
time ./bwa mem -t $num_threads -k 16 -c 20000 $index_path/HG_index_BWA_default/hsapiens_v37.fa $dataset_path/$IN.fastq > $results_path/$OUT.sam 2> $log_path/$OUT.err

#Returning to original path
cd $original_path
