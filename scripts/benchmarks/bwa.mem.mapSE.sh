#!/bin/bash

#SBATCH --job-name="BWA-SE"
#SBATCH --exclusive
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=29900M
#SBATCH -w bane

#SBATCH --time=80:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --output=../../logs/BWA.SE.mapping.summary.log 
#SBATCH --error=../../logs/BWA.SE.mapping.summary.log

source ../common.sh
source ../node_profiles.sh

IN=$1
OUT_PREFIX=$IN
TAG="BWA"

#Changing working directory
original_path=`pwd`
mapper_path="../../software/mappers/bwa-0.7.13"
cd $mapper_path

index_path="../../../data/indexes"
dataset_path="../../../data/datasets"
results_path="../../../data/results/$TAG"
log_path="../../../logs/$TAG"
tools_path="../../../software/tools"

local_dataset_path="/tmp/data/datasets"
local_index_path="/tmp/data/indexes"
local_results_path="/tmp/data/results"

echo "> Benchmarks for BWA 0.7.13: $IN"

profile "likwid-memsweeper"

#$tools_path/FFC/flush_file $local_index_path/HG_index_BWA_default/hsapiens_v37.fa
#$tools_path/FFC/flush_file $local_index_path/HG_index_BWA_default/hsapiens_v37.fa.amb
#$tools_path/FFC/flush_file $local_index_path/HG_index_BWA_default/hsapiens_v37.fa.ann
#$tools_path/FFC/flush_file $local_index_path/HG_index_BWA_default/hsapiens_v37.fa.bwt
#$tools_path/FFC/flush_file $local_index_path/HG_index_BWA_default/hsapiens_v37.fa.pac
#$tools_path/FFC/flush_file $local_index_path/HG_index_BWA_default/hsapiens_v37.fa.sa

#$tools_path/FFC/flush_file $local_dataset_path/$IN.fastq

mkdir -p $results_path
mkdir -p $log_path
cp -R $index_path/HG_index_BWA_default $local_index_path
cp $dataset_path/SE.DUMMY.fastq $local_dataset_path 
cp $dataset_path/$IN.fastq $local_dataset_path

# Warm up
################################################################

OUT_T1="$TAG.$OUT_PREFIX.warm.t$num_threads"
echo "==> Mapping $OUT_T1"
profile "./bwa mem -t $num_threads $local_index_path/HG_index_BWA_default/hsapiens_v37.fa $local_dataset_path/SE.DUMMY.fastq > $local_results_path/$OUT_T1.sam 2> $log_path/$OUT_T1.log"

# Test multi-threading
################################################################
# Default -k [19]  and -c [10000]
# - Min seed length, matches shorter than (-k) will be missed
# - Discard MEMs with more than (-c) occurences 
#	  (insensitive parameter)
#################################################################

OUT_T2="$TAG.$OUT_PREFIX.default.t$num_threads"
echo "==> Mapping $OUT_T2"
profile "./bwa mem -t $num_threads $local_index_path/HG_index_BWA_default/hsapiens_v37.fa $local_dataset_path/$IN.fastq > $local_results_path/$OUT_T2.sam 2> $log_path/$OUT_T2.log"

OUT_T3="$TAG.$OUT_PREFIX.c500.t$num_threads"
echo "==> Mapping $OUT_T3"
profile "./bwa mem -t $num_threads -c 500 $local_index_path/HG_index_BWA_default/hsapiens_v37.fa $local_dataset_path/$IN.fastq > $local_results_path/$OUT_T3.sam 2> $log_path/$OUT_T3.log"

OUT_T4="$TAG.$OUT_PREFIX.c1000.t$num_threads"
echo "==> Mapping $OUT_T4"
profile "./bwa mem -t $num_threads -c 1000 $local_index_path/HG_index_BWA_default/hsapiens_v37.fa $local_dataset_path/$IN.fastq > $local_results_path/$OUT_T4.sam 2> $log_path/$OUT_T4.log"

OUT_T5="$TAG.$OUT_PREFIX.c16000.t$num_threads"
echo "==> Mapping $OUT_T5"
profile "./bwa mem -t $num_threads -c 16000 $local_index_path/HG_index_BWA_default/hsapiens_v37.fa $local_dataset_path/$IN.fastq > $local_results_path/$OUT_T5.sam 2> $log_path/$OUT_T5.log"

OUT_T6="$TAG.$OUT_PREFIX.c20000.k16.t$num_threads"
echo "==> Mapping $OUT_T6"
profile "./bwa mem -t $num_threads -k 16 -c 20000 $local_index_path/HG_index_BWA_default/hsapiens_v37.fa $dataset_path/$IN.fastq > $local_results_path/$OUT_T6.sam 2> $log_path/$OUT_T6.log"

# Moving results from local storage to lustre
################################################################
mv $local_results_path/$OUT_T1.sam $results_path
mv $local_results_path/$OUT_T2.sam $results_path
mv $local_results_path/$OUT_T3.sam $results_path
mv $local_results_path/$OUT_T4.sam $results_path
mv $local_results_path/$OUT_T5.sam $results_path
mv $local_results_path/$OUT_T6.sam $results_path

rm -Rf $local_index_path/HG_index_BWA_default
rm -f $local_dataset_path/SE.DUMMY.fastq
rm -f $local_dataset_path/$IN.fastq

#Returning to original path
cd $original_path
