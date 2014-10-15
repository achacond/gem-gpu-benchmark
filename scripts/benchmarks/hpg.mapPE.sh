#!/bin/bash

#SBATCH --job-name="HPG-PE"
#SBATCH --exclusive
#SBATCH -w huberman

#SBATCH --time=5:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --mail-type=end
#SBATCH --mail-user="alejandro.chacon@uab.es"

#SBATCH --output=../../logs/HPG.summary.log 
#SBATCH --error=../../logs/HPG.summary.log

source ../node_profiles.sh

IN=$1
OUT_PREFIX=$IN

#Changing working directory
original_path=`pwd`
mapper_path="../../software/mappers/hpg-aligner-2.0.0/bin"
cd $mapper_path

index_path="../../../../data/indexes"
dataset_path="../../../../data/datasets"
results_path="../../../../data/results"
log_path="../../../../logs"

echo "> Benchmarks for HPG-aligner 2.0.0: $IN"


# Warm up
################################################################

OUT="HPG.$OUT_PREFIX.warm.t$num_threads"
echo "==> Mapping $OUT"
\time -v ./hpg-aligner dna --cpu-threads=$num_threads --paired-min-distance=0 --paired-max-distance=1000 -i=$index_path/HG_index_hpg-aligner_default/hsapiens_v37.fa --fastq=$dataset_path/$IN.1.fastq --fastq2=$dataset_path/$IN.2.fastq -o=$results_path/$OUT.sam > $log_path/$OUT.log 2>&1


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

OUT="HPG.$OUT_PREFIX.fast.t$num_threads"
echo "==> Mapping $OUT"
\time -v ./hpg-aligner dna --cpu-threads=$num_threads --num-seeds=10 --paired-min-distance=0 --paired-max-distance=1000 -i=$index_path/HG_index_hpg-aligner_default/hsapiens_v37.fa --fastq=$dataset_path/$IN.1.fastq --fastq2=$dataset_path/$IN.2.fastq -o=$results_path/$OUT.sam > $log_path/$OUT.log 2>&1

OUT="HPG.$OUT_PREFIX.default.t$num_threads"
echo "==> Mapping $OUT"
\time -v ./hpg-aligner dna --cpu-threads=$num_threads --paired-min-distance=0 --paired-max-distance=1000 -i=$index_path/HG_index_hpg-aligner_default/hsapiens_v37.fa --fastq=$dataset_path/$IN.1.fastq --fastq2=$dataset_path/$IN.2.fastq -o=$results_path/$OUT.sam > $log_path/$OUT.log 2>&1

OUT="HPG.$OUT_PREFIX.sensitive.t$num_threads"
echo "==> Mapping $OUT"
\time -v ./hpg-aligner dna --cpu-threads=$num_threads --num-seeds=40 --paired-min-distance=0 --paired-max-distance=1000 -i=$index_path/HG_index_hpg-aligner_default/hsapiens_v37.fa --fastq=$dataset_path/$IN.1.fastq --fastq2=$dataset_path/$IN.2.fastq -o=$results_path/$OUT.sam > $log_path/$OUT.log 2>&1


#Returning to original path
cd $original_path
