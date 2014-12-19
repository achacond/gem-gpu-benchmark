#!/bin/bash

#SBATCH --job-name="NVBOWTIE-SE"
#SBATCH --exclusive
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=62G
#SBATCH -w robin
#SBATCH --gres=gpu:1

#SBATCH --time=20:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --output=../../logs/NVBOWTIE.SE.mapping.summary.log 
#SBATCH --error=../../logs/NVBOWTIE.SE.mapping.summary.log

source ../common.sh
source ../node_profiles.sh

IN=$1
OUT_PREFIX=$IN
TAG="NVBOWTIE"

#Changing working directory
original_path=`pwd`
mapper_path="../../software/mappers/nvbio-0.9.9.3/release/nvBowtie"
cd $mapper_path

index_path="../../../../../data/indexes"
dataset_path="../../../../../data/datasets"
results_path="../../../../../data/results/$TAG"
log_path="../../../../../logs/$TAG"
tools_path="../../../software/tools"

local_dataset_path="/tmp/data/datasets"
local_index_path="/tmp/data/indexes"
local_results_path="/tmp/data/results"

echo "> Benchmarks for NVBOWTIE 0.9.9.3: $IN"

#$tools_path/FFC/flush_file $local_index_path/HG_index_NvBowtie_default/hsapiens_v37.fa.sa
#$tools_path/FFC/flush_file $local_index_path/HG_index_NvBowtie_default/hsapiens_v37.fa.rsa
#$tools_path/FFC/flush_file $local_index_path/HG_index_NvBowtie_default/hsapiens_v37.fa.rpac
#$tools_path/FFC/flush_file $local_index_path/HG_index_NvBowtie_default/hsapiens_v37.fa.rbwt
#$tools_path/FFC/flush_file $local_index_path/HG_index_NvBowtie_default/hsapiens_v37.fa.pac
#$tools_path/FFC/flush_file $local_index_path/HG_index_NvBowtie_default/hsapiens_v37.fa.bwt
#$tools_path/FFC/flush_file $local_index_path/HG_index_NvBowtie_default/hsapiens_v37.fa.ann
#$tools_path/FFC/flush_file $local_index_path/HG_index_NvBowtie_default/hsapiens_v37.fa.amb

profile "likwid-memsweeper"

mkdir -p $results_path
mkdir -p $log_path
#mkdir $local_path/HG_index_NvBowtie_default
#cp -R $index_path/HG_index_NvBowtie_default $local_index_path 
cp $dataset_path/$IN.fastq $local_dataset_path

# Warm up
################################################################

OUT_T1="NVBOWTIE.$OUT_PREFIX.warm.K20"
echo "==> Mapping $OUT_T1"
profile "./nvBowtie --seed-len 22 --max-reseed 2 --file-ref $local_index_path/HG_index_NvBowtie_default/hsapiens_v37.fa $local_dataset_path/$IN.fastq $local_results_path/$OUT_T1.sam > $log_path/$OUT_T1.log 2>&1"

# Test multi-threading
################################################################
#  --seed-len         int [22]      seed lengths
#  --max-reseed       int [2]       number of reseeding rounds
################################################################

OUT_T2="$TAG.$OUT_PREFIX.very-fast.K20"
echo "==> Mapping $OUT_T2"
profile "./nvBowtie --seed-len 22 --max-reseed 1 --file-ref $local_index_path/HG_index_NvBowtie_default/hsapiens_v37.fa $local_dataset_path/$IN.fastq $local_results_path/$OUT_T2.sam > $log_path/$OUT_T2.log 2>&1"

OUT_T3="$TAG.$OUT_PREFIX.default.K20"
echo "==> Mapping $OUT_T3"
profile "./nvBowtie --seed-len 22 --max-reseed 2 --file-ref $local_index_path/HG_index_NvBowtie_default/hsapiens_v37.fa $local_dataset_path/$IN.fastq $local_results_path/$OUT_T3.sam > $log_path/$OUT_T3.log 2>&1"

OUT_T4="$TAG.$OUT_PREFIX.very-sensitive.K20"
echo "==> Mapping $OUT_T4"
profile "./nvBowtie --seed-len 20 --max-reseed 3 --file-ref $local_index_path/HG_index_NvBowtie_default/hsapiens_v37.fa $local_dataset_path/$IN.fastq $local_results_path/$OUT_T4.sam > $log_path/$OUT_T4.log 2>&1"

# Moving results from local storage to lustre
################################################################
mv $local_results_path/$OUT_T1.sam $results_path
mv $local_results_path/$OUT_T2.sam $results_path
mv $local_results_path/$OUT_T3.sam $results_path
mv $local_results_path/$OUT_T4.sam $results_path

#rm -Rf $local_index_path/HG_index_NvBowtie_default
rm -f $local_dataset_path/$IN.fastq

#Returning to original path
cd $original_path
