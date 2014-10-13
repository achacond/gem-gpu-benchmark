#!/bin/bash

#SBATCH --job-name="SNAP-PE"
#SBATCH --exclusive
#SBATCH -w huberman

#SBATCH --time=1:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --mail-type=end
#SBATCH --mail-user="alejandro.chacon@uab.es"

#SBATCH --output=../../logs/SNAP.summary.log 
#SBATCH --error=../../logs/SNAP.summary.log

source ../node_profiles.sh

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

echo "> Benchmarks for SNAP 1.0Beta.10: $IN"

# Warm up
################################################################

OUT="SNAP.$OUT_PREFIX.warm.t$num_threads"
echo "==> Mapping $OUT"
time ./snap paired $index_path/HG_index_SNAP_short_reads $dataset_path/$IN.1.fastq $dataset_path/$IN.2.fastq -t 1 -h 50 -H 500 -s 0 1000 -o $results_path/$OUT.sam > $log_path/$OUT.log 2>&1


# Test single-thread
################################################################

#OUT="SNAP.$OUT_PREFIX.h50.t1"
#echo "==> Mapping $OUT"
#time ./snap paired $index_path/HG_index_SNAP_short_reads $dataset_path/$IN.1.fastq $dataset_path/$IN.2.fastq -t 1 -h 50 -H 500 -s 0 1000 -o $results_path/$OUT.sam > $log_path/$OUT.log 2>&1

#OUT="SNAP.$OUT_PREFIX.h100.t1"
#echo "==> Mapping $OUT"
#time ./snap paired $index_path/HG_index_SNAP_short_reads $dataset_path/$IN.1.fastq $dataset_path/$IN.2.fastq -t 1 -h 100 -H 1000 -s 0 1000 -o $results_path/$OUT.sam > $log_path/$OUT.log 2>&1

#OUT="SNAP.$OUT_PREFIX.h1000.t1"
#echo "==> Mapping $OUT"
#time ./snap paired $index_path/HG_index_SNAP_short_reads $dataset_path/$IN.1.fastq $dataset_path/$IN.2.fastq -t 1 -h 1000 -H 16000 -s 0 1000 -o $results_path/$OUT.sam > $log_path/$OUT.log 2>&1

#OUT="SNAP.$OUT_PREFIX.h2000.t1"
#echo "==> Mapping $OUT"
#time ./snap paired $index_path/HG_index_SNAP_short_reads $dataset_path/$IN.1.fastq $dataset_path/$IN.2.fastq -t 1 -h 2000 -H 20000 -s 0 1000 -o $results_path/$OUT.sam > $log_path/$OUT.log 2>&1



# Test multi-threading
################################################################

OUT="SNAP.$OUT_PREFIX.h50.t$num_threads"
echo "==> Mapping $OUT"
time ./snap paired $index_path/HG_index_SNAP_short_reads $dataset_path/$IN.1.fastq $dataset_path/$IN.2.fastq -t $num_threads -h 50 -H 500 -s 0 1000 -o $results_path/$OUT.sam > $log_path/$OUT.log 2>&1

OUT="SNAP.$OUT_PREFIX.h100.t$num_threads"
echo "==> Mapping $OUT"
time ./snap paired $index_path/HG_index_SNAP_short_reads $dataset_path/$IN.1.fastq $dataset_path/$IN.2.fastq -t $num_threads -h 100 -H 1000 -s 0 1000 -o $results_path/$OUT.sam > $log_path/$OUT.log 2>&1

OUT="SNAP.$OUT_PREFIX.h1000.t$num_threads"
echo "==> Mapping $OUT"
time ./snap paired $index_path/HG_index_SNAP_short_reads $dataset_path/$IN.1.fastq $dataset_path/$IN.2.fastq -t $num_threads -h 1000 -H 16000 -s 0 1000 -o $results_path/$OUT.sam > $log_path/$OUT.log 2>&1

OUT="SNAP.$OUT_PREFIX.h2000.t$num_threads"
echo "==> Mapping $OUT"
time ./snap paired $index_path/HG_index_SNAP_short_reads $dataset_path/$IN.1.fastq $dataset_path/$IN.2.fastq -t $num_threads -h 2000 -H 20000 -s 0 1000 -o $results_path/$OUT.sam > $log_path/$OUT.log 2>&1

#Returning to original path
cd $original_path


