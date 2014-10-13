#!/bin/bash

#SBATCH --job-name="BWA-PE"
#SBATCH --exclusive
#SBATCH -w huberman

#SBATCH --time=5:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --mail-type=end
#SBATCH --mail-user="alejandro.chacon@uab.es"

#SBATCH --output=../../logs/BWA.summary.log 
#SBATCH --error=../../logs/BWA.summary.log

source ../node_profiles.sh

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
time ./bwa mem -p $index_path/HG_index_BWA_default/hsapiens_v37.fa $dataset_path/$IN.fastq > $results_path/$OUT.sam 2> $log_path/$OUT.log

# Test single-thread
################################################################
# Default -k [19]  and -c [10000]
# - Min seed length, matches shorter than (-k) will be missed
# - Discard MEMs with more than (-c) occurences 
#	  (insensitive parameter)
#################################################################

#OUT=BWA.$OUT_PREFIX.t1
#echo "==> Mapping $OUT"
#time ./bwa mem -p $index_path/HG_index_BWA_default/hsapiens_v37.fa $dataset_path/$IN.fastq > $results_path/$OUT.sam 2> $log_path/$OUT.log

#OUT=BWA.$OUT_PREFIX.c500.t1
#echo "==> Mapping $OUT"
#time ./bwa mem -p -c 500 $index_path/HG_index_BWA_default/hsapiens_v37.fa $dataset_path/$IN.fastq > $results_path/$OUT.sam 2> $log_path/$OUT.log

#OUT=BWA.$OUT_PREFIX.c1000.t1
#echo "==> Mapping $OUT"
#time ./bwa mem -p -c 1000 $index_path/HG_index_BWA_default/hsapiens_v37.fa $dataset_path/$IN.fastq > $results_path/$OUT.sam 2> $log_path/$OUT.log

#OUT=BWA.$OUT_PREFIX.c16000.t1
#echo "==> Mapping $OUT"
#time ./bwa mem -p -c 16000 $index_path/HG_index_BWA_default/hsapiens_v37.fa $dataset_path/$IN.fastq > $results_path/$OUT.sam 2> $log_path/$OUT.log

#OUT=BWA.$OUT_PREFIX.c20000.k16.t1
#echo "==> Mapping $OUT"
#time ./bwa mem -p -k 16 -c 20000 $index_path/HG_index_BWA_default/hsapiens_v37.fa $dataset_path/$IN.fastq > $results_path/$OUT.sam 2> $log_path/$OUT.log

# Test multi-threading
################################################################
OUT="BWA.$OUT_PREFIX.t$num_threads"
echo "==> Mapping $OUT"
time ./bwa mem -p -t $num_threads $index_path/HG_index_BWA_default/hsapiens_v37.fa $dataset_path/$IN.fastq > $results_path/$OUT.sam 2> $log_path/$OUT.log

OUT="BWA.$OUT_PREFIX.c500.t$num_threads"
echo "==> Mapping $OUT"
time ./bwa mem -p -t $num_threads -c 500 $index_path/HG_index_BWA_default/hsapiens_v37.fa $dataset_path/$IN.fastq > $results_path/$OUT.sam 2> $log_path/$OUT.log

OUT="BWA.$OUT_PREFIX.c1000.t$num_threads"
echo "==> Mapping $OUT"
time ./bwa mem -p -t $num_threads -c 1000 $index_path/HG_index_BWA_default/hsapiens_v37.fa $dataset_path/$IN.fastq > $results_path/$OUT.sam 2> $log_path/$OUT.log

OUT="BWA.$OUT_PREFIX.c16000.t$num_threads"
echo "==> Mapping $OUT"
time ./bwa mem -p -t $num_threads -c 16000 $index_path/HG_index_BWA_default/hsapiens_v37.fa $dataset_path/$IN.fastq > $results_path/$OUT.sam 2> $log_path/$OUT.log

OUT="BWA.$OUT_PREFIX.c20000.k16.t$num_threads"
echo "==> Mapping $OUT"
time ./bwa mem -p -t $num_threads -k 16 -c 20000 $index_path/HG_index_BWA_default/hsapiens_v37.fa $dataset_path/$IN.fastq > $results_path/$OUT.sam 2> $log_path/$OUT.log


#Returning to original path
cd $original_path
