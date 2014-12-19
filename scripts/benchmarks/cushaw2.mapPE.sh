#!/bin/bash

#SBATCH --job-name="CUSHAW2-PE"
#SBATCH --exclusive
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=62G
#SBATCH -w robin
#SBATCH --gres=gpu:1

#SBATCH --time=20:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --output=../../logs/CUSHAW2.PE.mapping.summary.log 
#SBATCH --error=../../logs/CUSHAW2.PE.mapping.summary.log

source ../common.sh
source ../node_profiles.sh

IN=$1
OUT_PREFIX=$IN
TAG="CUSHAW2"

#Changing working directory
original_path=`pwd`
mapper_path="../../software/mappers/cushaw2-gpu-2.1.8-r16"
cd $mapper_path

index_path="../../../data/indexes"
dataset_path="../../../data/datasets"
results_path="../../../data/results/$TAG"
log_path="../../../logs/$TAG"
tools_path="../../../software/tools"

local_dataset_path="/tmp/data/datasets"
local_index_path="/tmp/data/indexes"
local_results_path="/tmp/data/results"

echo "> Benchmarks for CUSHAW2 GPU 2.1.8-r16: $IN"

#$tools_path/FFC/flush_file $local_index_path/HG_index_cushaw2-gpu_default/hsapiens_v37.fa
#$tools_path/FFC/flush_file $local_index_path/HG_index_cushaw2-gpu_default/hsapiens_v37.fa.amb
#$tools_path/FFC/flush_file $local_index_path/HG_index_cushaw2-gpu_default/hsapiens_v37.fa.ann
#$tools_path/FFC/flush_file $local_index_path/HG_index_cushaw2-gpu_default/hsapiens_v37.fa.pac
#$tools_path/FFC/flush_file $local_index_path/HG_index_cushaw2-gpu_default/hsapiens_v37.fa.rbwt
#$tools_path/FFC/flush_file $local_index_path/HG_index_cushaw2-gpu_default/hsapiens_v37.fa.rpac
#$tools_path/FFC/flush_file $local_index_path/HG_index_cushaw2-gpu_default/hsapiens_v37.fa.rsa

profile "likwid-memsweeper"

mkdir -p $results_path
mkdir -p $log_path
#mkdir $local_path/HG_index_cushaw2-gpu_default
#cp -R $index_path/HG_index_cushaw2-gpu_default $local_index_path 
cp $dataset_path/$IN.1.fastq $local_dataset_path
cp $dataset_path/$IN.2.fastq $local_dataset_path


# Warm up
################################################################

OUT_T1="$TAG.$OUT_PREFIX.warm.K20"
echo "==> Mapping $OUT_T1"
profile "./cushaw2-gpu -t $num_threads -r $local_index_path/HG_index_cushaw2-gpu_default/hsapiens_v37.fa -q $local_dataset_path/$IN.1.fastq $local_dataset_path/$IN.2.fastq -o $local_results_path/$OUT_T1.sam > $log_path/$OUT_T1.log 2>&1"

# Test multi-threading
################################################################
#  -r <string> (the file name base for the reference genome)
#  -f <string> file1 [file2] (single-end sequence files in FASTA/FASTQ format)
#  -q <string> file1_1 file1_2  [file2_1 file2_2] (paired-end sequence files in FASTA/FASTQ format)
#  -o <string> (SAM output file path, default = STDOUT)
#  -sensitive (concerned more about the sensitivity, only using min_score)
################################################################

OUT_T2="$TAG.$OUT_PREFIX.default.K20"
echo "==> Mapping $OUT_T2"
profile "./cushaw2-gpu -t $num_threads -r $local_index_path/HG_index_cushaw2-gpu_default/hsapiens_v37.fa -q $local_dataset_path/$IN.1.fastq $local_dataset_path/$IN.2.fastq -o $local_results_path/$OUT_T2.sam > $log_path/$OUT_T2.log 2>&1"

OUT_T3="$TAG.$OUT_PREFIX.sensitive.K20"
echo "==> Mapping $OUT_T3"
profile "./cushaw2-gpu -t $num_threads -sensitive -r $local_index_path/HG_index_cushaw2-gpu_default/hsapiens_v37.fa -q $local_dataset_path/$IN.1.fastq $local_dataset_path/$IN.2.fastq -o $local_results_path/$OUT_T3.sam >$log_path/$OUT_T3.log 2>&1"

# Moving results from local storage to lustre
################################################################
mv $local_results_path/$OUT_T1.sam $results_path
mv $local_results_path/$OUT_T2.sam $results_path
mv $local_results_path/$OUT_T3.sam $results_path

#rm -Rf $local_index_path/HG_index_cushaw2-gpu_default
rm -f $local_dataset_path/$IN.1.fastq
rm -f $local_dataset_path/$IN.2.fastq

#Returning to original path
cd $original_path
