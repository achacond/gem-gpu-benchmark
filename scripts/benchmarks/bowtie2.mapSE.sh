#!/bin/bash

#SBATCH --job-name="Bowtie-SE"
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
mapper_path="../../software/mappers/bowtie2-2.2.3"
cd $mapper_path

index_path="../../../data/indexes"
dataset_path="../../../data/datasets"
results_path="../../../data/results"
log_path="../../../logs"

echo "> Benchmarks for BOWTIE2 2.2.3: $IN"

# Warm up
################################################################

OUT="BOWTIE2.$OUT_PREFIX.warm.t$num_threads"
echo "==> Mapping $OUT"
time ./bowtie2 --threads $num_threads -x $index_path/HG_index_bowtie2_default/hsapiens -U $dataset_path/$IN.fastq -S $results_path/$OUT.sam 2> $log_path/$OUT.err > $log_path/$OUT.out

# Test multi-threading
################################################################

OUT="BOWTIE2.$OUT_PREFIX.very.fast.t$num_threads"
echo "==> Mapping $OUT"
time ./bowtie2 --threads $num_threads --very-fast -x $index_path/HG_index_bowtie2_default/hsapiens -U $dataset_path/$IN.fastq -S $results_path/$OUT.sam 2> $log_path/$OUT.err > $log_path/$OUT.out

OUT="BOWTIE2.$OUT_PREFIX.default.t$num_threads"
echo "==> Mapping $OUT"
time ./bowtie2 --threads $num_threads -x $index_path/HG_index_bowtie2_default/hsapiens -U $dataset_path/$IN.fastq -S $results_path/$OUT.sam 2> $log_path/$OUT.err > $log_path/$OUT.out

OUT="BOWTIE2.$OUT_PREFIX.very.sensitive.t$num_threads"
echo "==> Mapping $OUT"
time ./bowtie2 --threads $num_threads --very-sensitive -x $index_path/HG_index_bowtie2_default/hsapiens -U $dataset_path/$IN.fastq -S $results_path/$OUT.sam 2> $log_path/$OUT.err > $log_path/$OUT.out

#Returning to original path
cd $original_path
