#!/bin/bash

#SBATCH --job-name="Bowtie-PE"
#SBATCH --exclusive
#SBATCH -w huberman

#SBATCH --time=5:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --mail-type=end
#SBATCH --mail-user="alejandro.chacon@uab.es"

#SBATCH --output=../../logs/BOWTIE2.summary.log 
#SBATCH --error=../../logs/BOWTIE2.summary.log

source ../node_profiles.sh

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

echo "> Benchmarks for BOWTIE2 2.2.3: $IN"

# Warm up
################################################################
OUT="BOWTIE2.$OUT_PREFIX.warm.t$num_threads"
echo "==> Mapping $OUT"
time ./bowtie2 --threads $num_threads -X 1000 -x $index_path/HG_index_bowtie2_default/hsapiens -1 $dataset_path/$IN.1.fastq -2 $dataset_path/$IN.2.fastq -S $results_path/$OUT.sam > $log_path/$OUT.log 2>&1


# Test single-thread
################################################################

#OUT="BOWTIE2.$OUT_PREFIX.very.fast.t1"
#echo "==> Mapping $OUT"
#time ./bowtie2 --very-fast -X 1000 -x $index_path/HG_index_bowtie2_default/hsapiens -1 $dataset_path/$IN.1.fastq -2 $dataset_path/$IN.2.fastq -S $results_path/$OUT.sam > $log_path/$OUT.log 2>&1

#OUT="BOWTIE2.$OUT_PREFIX.default.t1"
#echo "==> Mapping $OUT"
#time ./bowtie2             -X 1000 -x $index_path/HG_index_bowtie2_default/hsapiens -1 $dataset_path/$IN.1.fastq -2 $dataset_path/$IN.2.fastq -S $results_path/$OUT.sam > $log_path/$OUT.log 2>&1

#OUT="BOWTIE2.$OUT_PREFIX.very.sensitive.t1"
#echo "==> Mapping $OUT"
#time ./bowtie2 --very-sensitive -X 1000 -x $index_path/HG_index_bowtie2_default/hsapiens -1 $dataset_path/$IN.1.fastq -2 $dataset_path/$IN.2.fastq -S $results_path/$OUT.sam > $log_path/$OUT.log 2>&1


# Test multi-threading
################################################################

OUT="BOWTIE2.$OUT_PREFIX.very.fast.t$num_threads"
echo "==> Mapping $OUT"
time ./bowtie2 --threads $num_threads --very-fast -X 1000 -x $index_path/HG_index_bowtie2_default/hsapiens -1 $dataset_path/$IN.1.fastq -2 $dataset_path/$IN.2.fastq -S $results_path/$OUT.sam > $log_path/$OUT.log 2>&1

OUT="BOWTIE2.$OUT_PREFIX.default.t$num_threads"
echo "==> Mapping $OUT"
time ./bowtie2 --threads $num_threads -X 1000 -x $index_path/HG_index_bowtie2_default/hsapiens -1 $dataset_path/$IN.1.fastq -2 $dataset_path/$IN.2.fastq -S $results_path/$OUT.sam > $log_path/$OUT.log 2>&1

OUT="BOWTIE2.$OUT_PREFIX.very.sensitive.t$num_threads"
echo "==> Mapping $OUT"
time ./bowtie2 --threads $num_threads --very-sensitive -X 1000 -x $index_path/HG_index_bowtie2_default/hsapiens -1 $dataset_path/$IN.1.fastq -2 $dataset_path/$IN.2.fastq -S $results_path/$OUT.sam > $log_path/$OUT.log 2>&1

#Returning to original path
cd $original_path
