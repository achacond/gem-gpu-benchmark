#!/bin/bash

#SBATCH --job-name="GEM-SE"
#SBATCH --exclusive
#SBATCH -w huberman

#SBATCH --time=1:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --mail-type=end
#SBATCH --mail-user="alejandro.chacon@uab.es"

#SBATCH --output=../../logs/GEM.summary.log 
#SBATCH --error=../../logs/GEM.summary.log

source ../node_profiles.sh

IN=$1
OUT_PREFIX=$IN

#Changing working directory
original_path=`pwd`
mapper_path="../../software/mappers/gem-gpu"
cd $mapper_path

index_path="../../../data/indexes"
dataset_path="../../../data/datasets"
results_path="../../../data/results"
log_path="../../../logs"

echo "> Benchmarks for GEM-GPU (git): $IN"

# Warm up
################################################################

OUT="GEM-GPU.$OUT_PREFIX.warm.t$num_threads"
echo "==> Mapping $OUT"
time bin/gem-mapper -t $num_threads --stats -I $index_path/HG_index_GEM-GPU_profile_FR_S4_default/hsapiens_v37.FR.s4.gem -i $dataset_path/$IN.fastq -o $results_path/$OUT.sam > $log_path/$OUT.log 2>&1


# Test multi-threading
################################################################

OUT="GEM-GPU.$OUT_PREFIX.t$num_threads"
echo "==> Mapping $OUT"
time bin/gem-mapper -t $num_threads --stats -I $index_path/HG_index_GEM-GPU_profile_FR_S4_default/hsapiens_v37.FR.s4.gem -i $dataset_path/$IN.fastq -o $results_path/$OUT.sam > $log_path/$OUT.log 2>&1
#Returning to original path

# Test multi-threading + GPU
################################################################

OUT="GEM-GPU.$OUT_PREFIX.t$num_threads.cuda"
echo "==> Mapping $OUT"
time bin/gem-mapper -t $num_threads --stats --cuda -I $index_path/HG_index_GEM-GPU_profile_FR_S4_default/hsapiens_v37.FR.s4.gem -i $dataset_path/$IN.fastq -o $results_path/$OUT.sam > $log_path/$OUT.log 2>&1
#Returning to original path
cd $original_path
