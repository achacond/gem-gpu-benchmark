#!/bin/bash

#SBATCH --job-name="SNAP-PE"
#SBATCH --exclusive
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=29900M
#SBATCH -w bane

#SBATCH --time=80:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --output=../../logs/SNAP.PE.mapping.summary.log 
#SBATCH --error=../../logs/SNAP.PE.mapping.summary.log

source ../common.sh
source ../node_profiles.sh

IN=$1
OUT_PREFIX=$IN
TAG="SNAP"

#Changing working directory
original_path=`pwd`
mapper_path="../../software/mappers/snap-1.0beta.18"
cd $mapper_path

index_path="../../../data/indexes"
dataset_path="../../../data/datasets"
results_path="../../../data/results/$TAG"
log_path="../../../logs/$TAG"
tools_path="../../../software/tools"

local_dataset_path="/tmp/data/datasets"
local_index_path="/tmp/data/indexes"
local_results_path="/tmp/data/results"

echo "> Benchmarks for SNAP 1.0Beta.18: $IN"

profile "likwid-memsweeper"

mkdir -p $results_path
mkdir -p $log_path
cp -R $index_path/HG_index_SNAP_default $local_index_path
cp $dataset_path/PE.DUMMY.1.fastq $local_dataset_path
cp $dataset_path/PE.DUMMY.2.fastq $local_dataset_path 
cp $dataset_path/$IN.1.fastq $local_dataset_path
cp $dataset_path/$IN.2.fastq $local_dataset_path

#$tools_path/FFC/flush_file $local_index_path/HG_index_SNAP_"$indexSize"_reads/Genome
#$tools_path/FFC/flush_file $local_index_path/HG_index_SNAP_"$indexSize"_reads/GenomeIndex
#$tools_path/FFC/flush_file $local_index_path/HG_index_SNAP_"$indexSize"_reads/GenomeIndexHash
#$tools_path/FFC/flush_file $local_index_path/HG_index_SNAP_"$indexSize"_reads/OverflowTable

#$tools_path/FFC/flush_file $local_dataset_path/$IN.1.fastq
#$tools_path/FFC/flush_file $local_dataset_path/$IN.2.fastq

# Warm up
################################################################

OUT_T1="$TAG.$OUT_PREFIX.warm.t$num_threads"
echo "==> Mapping $OUT_T1"
profile "./snap-aligner paired $local_index_path/HG_index_SNAP_default $local_dataset_path/PE.DUMMY.1.fastq $local_dataset_path/PE.DUMMY.2.fastq -t 1 -h 50 -H 500 -s 0 1000 -o $local_results_path/$OUT_T1.sam > $log_path/$OUT_T1.log 2>&1"

# Test multi-threading
################################################################

OUT_T2="$TAG.$OUT_PREFIX.h50.t$num_threads"
echo "==> Mapping $OUT_T2"
profile "./snap-aligner paired $local_index_path/HG_index_SNAP_default $local_dataset_path/$IN.1.fastq $local_dataset_path/$IN.2.fastq -t $num_threads -h 50 -H 500 -s 0 1000 -o $local_results_path/$OUT_T2.sam > $log_path/$OUT_T2.log 2>&1"


OUT_T3="$TAG.$OUT_PREFIX.default.t$num_threads"
echo "==> Mapping $OUT_T3"
profile "./snap-aligner paired $local_index_path/HG_index_SNAP_default $local_dataset_path/$IN.1.fastq $local_dataset_path/$IN.2.fastq -t $num_threads -h 300 -H 1000 -s 0 1000 -o $local_results_path/$OUT_T3.sam > $log_path/$OUT_T3.log 2>&1"


OUT_T4="$TAG.$OUT_PREFIX.h1000.t$num_threads"
echo "==> Mapping $OUT_T4"
profile "./snap-aligner paired $local_index_path/HG_index_SNAP_default $local_dataset_path/$IN.1.fastq $local_dataset_path/$IN.2.fastq -t $num_threads -h 1000 -H 16000 -s 0 1000 -o $local_results_path/$OUT_T4.sam > $log_path/$OUT_T4.log 2>&1"


OUT_T5="$TAG.$OUT_PREFIX.h2000.t$num_threads"
echo "==> Mapping $OUT_T5"
profile "./snap-aligner paired $local_index_path/HG_index_SNAP_default $local_dataset_path/$IN.1.fastq $local_dataset_path/$IN.2.fastq -t $num_threads -h 2000 -H 20000 -s 0 1000 -o $local_results_path/$OUT_T5.sam > $log_path/$OUT_T5.log 2>&1"

# Moving results from local storage to lustre
################################################################
mv $local_results_path/$OUT_T1.sam $results_path
mv $local_results_path/$OUT_T2.sam $results_path
mv $local_results_path/$OUT_T3.sam $results_path
mv $local_results_path/$OUT_T4.sam $results_path
mv $local_results_path/$OUT_T5.sam $results_path

rm -Rf $local_index_path/HG_index_SNAP_default
rm -f $local_dataset_path/PE.DUMMY.1.fastq
rm -f $local_dataset_path/PE.DUMMY.2.fastq
rm -f $local_dataset_path/$IN.1.fastq
rm -f $local_dataset_path/$IN.2.fastq

#Returning to original path
cd $original_path


