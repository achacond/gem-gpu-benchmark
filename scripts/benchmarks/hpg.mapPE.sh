#!/bin/bash

#SBATCH --job-name="HPG-PE"
#SBATCH --exclusive
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=62G
#SBATCH -w robin

#SBATCH --time=20:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --output=../../logs/HPG.PE.mapping.summary.log 
#SBATCH --error=../../logs/HPG.PE.mapping.summary.log

source ../common.sh
source ../node_profiles.sh

IN=$1
OUT_PREFIX=$IN
TAG="HPG"

#Changing working directory
original_path=`pwd`
mapper_path="../../software/mappers/hpg-aligner-2.0.0/bin"
cd $mapper_path

index_path="../../../../data/indexes"
dataset_path="../../../../data/datasets"
results_path="../../../../data/results/$TAG"
log_path="../../../../logs/$TAG"
tools_path="../../../../software/tools"

local_dataset_path="/tmp/data/datasets"
local_index_path="/tmp/data/indexes"
local_results_path="/tmp/data/results"

echo "> Benchmarks for HPG-aligner 2.0.0: $IN"

mkdir -p $results_path
mkdir -p $log_path
#mkdir $local_path/HG_index_bowtie2_default
#cp -R $index_path/HG_index_hpg-aligner_default $local_index_path 
cp $dataset_path/$IN.1.fastq $local_dataset_path
cp $dataset_path/$IN.2.fastq $local_dataset_path

profile "likwid-memsweeper"

# Warm up
################################################################

OUT_T1="$TAG.$OUT_PREFIX.warm.t$num_threads"
echo "==> Mapping $OUT_T1"
profile "./hpg-aligner dna --cpu-threads $num_threads --paired-min-distance 0 --paired-max-distance 1000 -i $local_index_path/HG_index_hpg-aligner_default -f $local_dataset_path/$IN.1.fastq -j $local_dataset_path/$IN.2.fastq -o $local_results_path/$OUT_T1.sam > $log_path/$OUT_T1.log 2>&1"


# Test multi-threading
################################################################
#   -i, --index=<file>                  Index directory name
#   -f, --fq, --fastq=<file>            Reads file input. For more than one file: f1.fq,f2.fq,...
#   -j, --fq2, --fastq2=<file>          Reads file input #2 (for paired mode)
#   -o, --outdir=<file>           		Output directory
#   -t, --cpu-threads=<int>             Number of CPU Threads
#   --paired-min-distance=<int>        	Minimum distance between pairs
#   --paired-max-distance=<int>        	Maximum distance between pairs
#   --num-seeds=<int>                   Number of seeds
################################################################

OUT_T2="$TAG.$OUT_PREFIX.fast.t$num_threads"
echo "==> Mapping $OUT_T2"
profile "./hpg-aligner dna --cpu-threads $num_threads --num-seeds 10 --paired-min-distance 0 --paired-max-distance 1000 -i $local_index_path/HG_index_hpg-aligner_default -f $local_dataset_path/$IN.1.fastq -j $local_dataset_path/$IN.2.fastq -o $local_results_path/$OUT_T2.sam > $log_path/$OUT_T2.log 2>&1"

OUT_T3="$TAG.$OUT_PREFIX.default.t$num_threads"
echo "==> Mapping $OUT_T3"
profile "./hpg-aligner dna --cpu-threads $num_threads --paired-min-distance 0 --paired-max-distance 1000 -i $local_index_path/HG_index_hpg-aligner_default -f $local_dataset_path/$IN.1.fastq -j $local_dataset_path/$IN.2.fastq -o $local_results_path/$OUT_T3.sam > $log_path/$OUT_T3.log 2>&1"

OUT_T4="$TAG.$OUT_PREFIX.sensitive.t$num_threads"
echo "==> Mapping $OUT_T4"
profile "./hpg-aligner dna --cpu-threads $num_threads --num-seeds 40 --paired-min-distance 0 --paired-max-distance 1000 -i $local_index_path/HG_index_hpg-aligner_default -f $local_dataset_path/$IN.1.fastq -j $local_dataset_path/$IN.2.fastq -o $local_results_path/$OUT_T4.sam > $log_path/$OUT_T4.log 2>&1"

# Moving results from local storage to lustre
################################################################
mv $local_results_path/$OUT_T1.sam/alignments.sam $results_path/$OUT_T1.sam
mv $local_results_path/$OUT_T2.sam/alignments.sam $results_path/$OUT_T2.sam
mv $local_results_path/$OUT_T3.sam/alignments.sam $results_path/$OUT_T3.sam
mv $local_results_path/$OUT_T4.sam/alignments.sam $results_path/$OUT_T4.sam
rm -Rf $local_results_path/$TAG.$OUT_PREFIX*

#rm -Rf $local_index_path/HG_index_hpg-aligner_default
rm -f $local_dataset_path/$IN.1.fastq
rm -f $local_dataset_path/$IN.2.fastq

#Returning to original path
cd $original_path
