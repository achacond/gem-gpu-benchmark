#!/bin/bash

#SBATCH --job-name="NVBOWTIE-PE"
#SBATCH --exclusive
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=29900M
#SBATCH -w bane
#SBATCH --gres=gpu:2

#SBATCH --time=80:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --output=../../logs/NVBOWTIE.PE.mapping.summary.log 
#SBATCH --error=../../logs/NVBOWTIE.PE.mapping.summary.log

echo $CUDA_VISIBLE_DEVICES > /tmp/nvidia-reset.$SLURM_JOB_ID

source ../common.sh
source ../node_profiles_CUDA65.sh

IN=$1
OUT_PREFIX=$IN
TAG="NVBOWTIE"

#Changing working directory
original_path=`pwd`
mapper_path="../../software/mappers/nvbio-1.1.0/release/nvBowtie"
cd $mapper_path

index_path="../../../../../data/indexes"
dataset_path="../../../../../data/datasets"
results_path="../../../../../data/results/$TAG"
log_path="../../../../../logs/$TAG"
tools_path="../../../software/tools"

local_dataset_path="/tmp/data/datasets"
local_index_path="/tmp/data/indexes"
local_results_path="/tmp/data/results"

echo "> Benchmarks for $TAG 1.1.0: $IN"

profile "likwid-memsweeper"

#$tools_path/FFC/flush_file $local_index_path/HG_index_NvBowtie_default/hsapiens_v37.fa.sa
#$tools_path/FFC/flush_file $local_index_path/HG_index_NvBowtie_default/hsapiens_v37.fa.rsa
#$tools_path/FFC/flush_file $local_index_path/HG_index_NvBowtie_default/hsapiens_v37.fa.rpac
#$tools_path/FFC/flush_file $local_index_path/HG_index_NvBowtie_default/hsapiens_v37.fa.rbwt
#$tools_path/FFC/flush_file $local_index_path/HG_index_NvBowtie_default/hsapiens_v37.fa.pac
#$tools_path/FFC/flush_file $local_index_path/HG_index_NvBowtie_default/hsapiens_v37.fa.bwt
#$tools_path/FFC/flush_file $local_index_path/HG_index_NvBowtie_default/hsapiens_v37.fa.ann
#$tools_path/FFC/flush_file $local_index_path/HG_index_NvBowtie_default/hsapiens_v37.fa.amb

mkdir -p $results_path
mkdir -p $log_path
cp -R $index_path/HG_index_NvBowtie_default $local_index_path
cp $dataset_path/PE.DUMMY.1.fastq $local_dataset_path
cp $dataset_path/PE.DUMMY.2.fastq $local_dataset_path 
cp $dataset_path/$IN.1.fastq $local_dataset_path
cp $dataset_path/$IN.2.fastq $local_dataset_path

# Warm up
################################################################

OUT_T1="$TAG.$OUT_PREFIX.warm.K40"
echo "==> Mapping $OUT_T1"
profile "./nvBowtie -X 1000 -x $local_index_path/HG_index_NvBowtie_default/ -1 $local_dataset_path/PE.DUMMY.1.fastq -2 $local_dataset_path/PE.DUMMY.2.fastq -S $local_results_path/$OUT_T1.sam > $log_path/$OUT_T1.log 2>&1"
#profile "./nvBowtie --seed-len 22 --max-reseed 2 --minins 0 --maxins 1000 --overlap --dovetail --file-ref $local_index_path/HG_index_NvBowtie_default/hsapiens_v37.fa $local_dataset_path/$IN.fastq $local_results_path/$OUT_T1.sam > $log_path/$OUT_T1.log 2>&1"


# Test multi-threading
################################################################
#  --seed-len         int [22]      seed lengths
#  --max-reseed       int [2]       number of reseeding rounds
#  --maxins           int [0]       minimum insert length
#  --minins           int [500]     maximum insert length
#  --overlap                        allow overlapping mates
#  --dovetail                       allow dovetailing mates
################################################################

OUT_T2="$TAG.$OUT_PREFIX.default.K40"
echo "==> Mapping $OUT_T2"
profile "./nvBowtie -X 1000 -x $local_index_path/HG_index_NvBowtie_default/ -1 $local_dataset_path/$IN.1.fastq -2 $local_dataset_path/$IN.2.fastq -S $local_results_path/$OUT_T2.sam > $log_path/$OUT_T2.log 2>&1"
#profile "./nvBowtie --seed-len 22 --max-reseed 2 --minins 0 --maxins 1000 --overlap --dovetail --file-ref $local_index_path/HG_index_NvBowtie_default/hsapiens_v37.fa $local_dataset_path/$IN.fastq $local_results_path/$OUT_T3.sam > $log_path/$OUT_T3.log 2>&1"

OUT_T3="$TAG.$OUT_PREFIX.very-fast.K40"
echo "==> Mapping $OUT_T3"
profile "./nvBowtie --very-fast -X 1000 -x $local_index_path/HG_index_NvBowtie_default/ -1 $local_dataset_path/$IN.1.fastq -2 $local_dataset_path/$IN.2.fastq -S $local_results_path/$OUT_T3.sam > $log_path/$OUT_T3.log 2>&1"
#profile "./nvBowtie --seed-len 22 --max-reseed 1 --minins 0 --maxins 1000 --overlap --dovetail --file-ref $local_index_path/HG_index_NvBowtie_default/hsapiens_v37.fa $local_dataset_path/$IN.fastq $local_results_path/$OUT_T2.sam > $log_path/$OUT_T2.log 2>&1"

OUT_T4="$TAG.$OUT_PREFIX.fast.K40"
echo "==> Mapping $OUT_T4"
profile "./nvBowtie --fast -X 1000 -x $local_index_path/HG_index_NvBowtie_default/ -1 $local_dataset_path/$IN.1.fastq -2 $local_dataset_path/$IN.2.fastq -S $local_results_path/$OUT_T4.sam > $log_path/$OUT_T4.log 2>&1"

OUT_T5="$TAG.$OUT_PREFIX.sensitive.K40"
echo "==> Mapping $OUT_T5"
profile "./nvBowtie --sensitive -X 1000 -x $local_index_path/HG_index_NvBowtie_default/ -1 $local_dataset_path/$IN.1.fastq -2 $local_dataset_path/$IN.2.fastq -S $local_results_path/$OUT_T5.sam > $log_path/$OUT_T5.log 2>&1"

OUT_T6="$TAG.$OUT_PREFIX.very-sensitive.K40"
echo "==> Mapping $OUT_T6"
profile "./nvBowtie --very-sensitive -X 1000 -x $local_index_path/HG_index_NvBowtie_default/ -1 $local_dataset_path/$IN.1.fastq -2 $local_dataset_path/$IN.2.fastq -S $local_results_path/$OUT_T6.sam > $log_path/$OUT_T6.log 2>&1"
#profile "./nvBowtie --seed-len 20 --max-reseed 3 --minins 0 --maxins 1000 --overlap --dovetail --file-ref $local_index_path/HG_index_NvBowtie_default/hsapiens_v37.fa $local_dataset_path/$IN.fastq $local_results_path/$OUT_T4.sam > $log_path/$OUT_T4.log 2>&1"


# Moving results from local storage to lustre
################################################################
mv $local_results_path/$OUT_T1.sam $results_path
mv $local_results_path/$OUT_T2.sam $results_path
mv $local_results_path/$OUT_T3.sam $results_path
mv $local_results_path/$OUT_T4.sam $results_path
mv $local_results_path/$OUT_T5.sam $results_path
mv $local_results_path/$OUT_T6.sam $results_path

rm -Rf $local_index_path/HG_index_NvBowtie_default
rm -f $local_dataset_path/PE.DUMMY.1.fastq
rm -f $local_dataset_path/PE.DUMMY.2.fastq
rm -f $local_dataset_path/$IN.fastq

#Returning to original path
cd $original_path
