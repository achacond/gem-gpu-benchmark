#!/bin/bash

#SBATCH --job-name="NVBOWTIE-SE"
#SBATCH --exclusive
#SBATCH -w huberman
#SBATCH --gres=gpu:2

#SBATCH --time=5:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --mail-type=end
#SBATCH --mail-user="alejandro.chacon@uab.es"

#SBATCH --output=../../logs/NVBOWTIE.summary.log 
#SBATCH --error=../../logs/NVBOWTIE.summary.log

source ../common.sh
source ../node_profiles.sh

IN=$1
OUT_PREFIX=$IN

#Changing working directory
original_path=`pwd`
mapper_path="../../software/mappers/nvbio-0.9.9.3/release/nvBowtie"
cd $mapper_path

index_path="../../../../../data/indexes"
dataset_path="../../../../../data/datasets"
results_path="../../../../../data/results"
log_path="../../../../../logs"

echo "> Benchmarks for NVBOWTIE 0.9.9.3: $IN"

# Warm up
################################################################

OUT="NVBOWTIE.$OUT_PREFIX.warm.K20"
echo "==> Mapping $OUT"
profile "./nvBowtie --seed-len 22 --max-reseed 2 --file-ref $index_path/HG_index_NvBowtie_default/hsapiens_v37.fa $dataset_path/$IN.fastq $results_path/$OUT.sam > $log_path/$OUT.log 2>&1"


# Test multi-threading
################################################################
#  --seed-len         int [22]      seed lengths
#  --max-reseed       int [2]       number of reseeding rounds
################################################################

OUT="NVBOWTIE.$OUT_PREFIX.very-fast.K20"
echo "==> Mapping $OUT"
profile "./nvBowtie --seed-len 22 --max-reseed 1 --file-ref $index_path/HG_index_NvBowtie_default/hsapiens_v37.fa $dataset_path/$IN.fastq $results_path/$OUT.sam > $log_path/$OUT.log 2>&1"

OUT="NVBOWTIE.$OUT_PREFIX.default.K20"
echo "==> Mapping $OUT"
profile "./nvBowtie --seed-len 22 --max-reseed 2 --file-ref $index_path/HG_index_NvBowtie_default/hsapiens_v37.fa $dataset_path/$IN.fastq $results_path/$OUT.sam > $log_path/$OUT.log 2>&1"


OUT="NVBOWTIE.$OUT_PREFIX.very-sensitive.K20"
echo "==> Mapping $OUT"
profile "./nvBowtie --seed-len 20 --max-reseed 3 --file-ref $index_path/HG_index_NvBowtie_default/hsapiens_v37.fa $dataset_path/$IN.fastq $results_path/$OUT.sam > $log_path/$OUT.log 2>&1"


#Returning to original path
cd $original_path
