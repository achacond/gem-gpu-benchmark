#!/bin/bash

#SBATCH --job-name="S.GEM3-GPU-SE"
#SBATCH --exclusive
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=62G
#SBATCH -w robin

#SBATCH --time=20:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --output=../../logs/GEM.mapping.summary.log 
#SBATCH --error=../../logs/GEM.mapping.summary.log

source ../common.sh
source ../node_profiles.sh

IN=$1
OUT_PREFIX=$IN
TAG="GEM3-GPU"

#Changing working directory
original_path=`pwd`
mapper_path="../../software/mappers/gem-gpu-git"
cd $mapper_path

index_path="../../../data/indexes"
dataset_path="../../../data/datasets"
results_path="../../../data/results/$TAG"
log_path="../../../logs/$TAG"
tools_path="../../../software/tools"

local_dataset_path="/tmp/data/datasets"
local_index_path="/tmp/data/indexes"
local_results_path="/tmp/data/results"

mkdir -p $results_path
mkdir -p $log_path
#mkdir $local_path/HG_index_GEM-GPU_profile_FR_S4_default
#cp -R $index_path/HG_index_GEM-GPU_profile_FR_S4_default $local_index_path
cp $dataset_path/$IN.fastq $local_dataset_path

echo "> Benchmarks for GEM-GPU (git): $IN"

#$tools_path/FFC/flush_file $local_index_path/HG_index_GEM-GPU_profile_FR_S4_default/hsapiens_v37.FR.s4.gem
#$tools_path/FFC/flush_file $local_dataset_path/$IN.fastq

profile "likwid-memsweeper"

# Warm up
################################################################

OUT_T1="$TAG.$OUT_PREFIX.warm.t$num_threads"
echo "==> Mapping $OUT_T1"
profile "bin/gem-mapper --profile -I $local_index_path/HG_index_GEM-GPU_profile_FR_S4_default/hsapiens_v37.FR.s4.gem -i $local_dataset_path/$IN.fastq -o $local_results_path/$OUT_T1.sam > $log_path/$OUT_T1.log 2>&1"

# Test multi-threading
################################################################

OUT_T2="$TAG.$OUT_PREFIX.t$num_threads"
echo "==> Mapping $OUT_T2"
profile "bin/gem-mapper --profile -I $local_index_path/HG_index_GEM-GPU_profile_FR_S4_default/hsapiens_v37.FR.s4.gem -i $local_dataset_path/$IN.fastq -o $local_results_path/$OUT_T2.sam > $log_path/$OUT_T2.log 2>&1"

# Test multi-threading + GPU
################################################################

OUT_T3="$TAG.$OUT_PREFIX.t$num_threads.K20"
echo "==> Mapping $OUT_T3"
profile "bin/gem-mapper --profile --cuda -I $local_index_path/HG_index_GEM-GPU_profile_FR_S4_default/hsapiens_v37.FR.s4.gem -i $local_dataset_path/$IN.fastq -o $local_results_path/$OUT_T3.sam > $log_path/$OUT_T3.log 2>&1"

# Moving results from local storage to lustre
################################################################
mv $local_results_path/$OUT_T1.sam $results_path
mv $local_results_path/$OUT_T2.sam $results_path
mv $local_results_path/$OUT_T3.sam $results_path

#rm -Rf $local_index_path/HG_index_GEM-GPU_profile_FR_S4_default
rm -f $local_dataset_path/$IN.fastq

#Returning to original path
cd $original_path
