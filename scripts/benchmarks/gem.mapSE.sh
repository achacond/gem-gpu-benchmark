#!/bin/bash

#SBATCH --job-name="GEM-SE"
#SBATCH --exclusive
#SBATCH -w huberman

#SBATCH --time=1:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --mail-type=ALL
#SBATCH --mail-user="alejandro.chacon@uab.es"

if [[ -n $(hostname | grep aopccuda) ]]; then
	source /etc/profile.d/module.sh
	module load GCC/4.9.1
	module load CUDA/6.5.14
	num_threads="8"
fi

if [[ -n $(hostname | grep huberman) ]]; then
	module load gcc/4.9.1
	module load cuda/6.5
	num_threads="32"
fi

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
time bin/gem-mapper -t $num_threads -v --stats -I $index_path/HG_index_GEM-GPU_profile_FR_S4_default/hsapiens_v37.FR.s4.gem -i $dataset_path/$IN.fastq -o $results_path/$OUT.sam > $log_path/$OUT.out 2> $log_path/$OUT.err


# Test multi-threading
################################################################

OUT="GEM-GPU.$OUT_PREFIX.t$num_threads"
echo "==> Mapping $OUT"
time bin/gem-mapper -t $num_threads -v --stats -I $index_path/HG_index_GEM-GPU_profile_FR_S4_default/hsapiens_v37.FR.s4.gem -i $dataset_path/$IN.fastq -o $results_path/$OUT.sam > $log_path/$OUT.out 2> $log_path/$OUT.err

#Returning to original path
cd $original_path
