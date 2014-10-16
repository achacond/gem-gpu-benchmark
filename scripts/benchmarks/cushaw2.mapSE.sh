#!/bin/bash

#SBATCH --job-name="CUSHAW2-PE"
#SBATCH --exclusive
#SBATCH -w huberman
#SBATCH --gres=gpu:2

#SBATCH --time=5:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --mail-type=end
#SBATCH --mail-user="alejandro.chacon@uab.es"

#SBATCH --output=../../logs/CUSHAW2.mapping.summary.log 
#SBATCH --error=../../logs/CUSHAW2.mapping.summary.log

source ../common.sh
source ../node_profiles.sh

IN=$1
OUT_PREFIX=$IN

#Changing working directory
original_path=`pwd`
mapper_path="../../software/mappers/cushaw2-gpu-2.1.8-r16"
cd $mapper_path

index_path="../../../data/indexes"
dataset_path="../../../data/datasets"
results_path="../../../data/results"
log_path="../../../logs"

echo "> Benchmarks for CUSHAW2 GPU 2.1.8-r16: $IN"


# Warm up
################################################################

OUT="CUSHAW2.$OUT_PREFIX.warm.K20"
echo "==> Mapping $OUT"
profile "./cushaw2-gpu -t $num_threads -r $index_path/HG_index_cushaw2-gpu_default/hsapiens_v37.fa -f $dataset_path/$IN.fastq -o $results_path/$OUT.sam > $log_path/$OUT.log 2>&1"


# Test multi-threading
################################################################
#  -r <string> (the file name base for the reference genome)
#  -f <string> file1 [file2] (single-end sequence files in FASTA/FASTQ format)
#  -q <string> file1_1 file1_2  [file2_1 file2_2] (paired-end sequence files in FASTA/FASTQ format)
#  -o <string> (SAM output file path, default = STDOUT)
#  -sensitive (concerned more about the sensitivity, only using min_score)
################################################################

OUT="CUSHAW2.$OUT_PREFIX.default.K20"
echo "==> Mapping $OUT"
profile "./cushaw2-gpu -t $num_threads -r $index_path/HG_index_cushaw2-gpu_default/hsapiens_v37.fa -f $dataset_path/$IN.fastq -o $results_path/$OUT.sam > $log_path/$OUT.log 2>&1"

OUT="CUSHAW2.$OUT_PREFIX.sensitive.K20"
echo "==> Mapping $OUT"
profile "./cushaw2-gpu -t $num_threads -sensitive -r $index_path/HG_index_cushaw2-gpu_default/hsapiens_v37.fa -f $dataset_path/$IN.fastq -o $results_path/$OUT.sam > $log_path/$OUT.log 2>&1"


#Returning to original path
cd $original_path
