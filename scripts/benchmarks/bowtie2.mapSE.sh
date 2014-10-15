#!/bin/bash

#SBATCH --job-name="BOWTIE2-SE"
#SBATCH --exclusive
#SBATCH -w huberman

#SBATCH --time=5:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --mail-type=end
#SBATCH --mail-user="alejandro.chacon@uab.es"

#SBATCH --output=../../logs/BOWTIE2.summary.log 
#SBATCH --error=../../logs/BOWTIE2.summary.log

source ../node_profiles.sh

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
\time ./bowtie2 --threads $num_threads -x $index_path/HG_index_bowtie2_default/hsapiens.fa -U $dataset_path/$IN.fastq -S $results_path/$OUT.sam > $log_path/$OUT.log 2>&1


# Test multi-threading
################################################################
#   bowtie2 [options]* -x <bt2-idx> {-1 <m1> -2 <m2> | -U <r>} [-S <sam>]
#
#   --very-fast            -D 5 -R 1 -N 0 -L 22 -i S,0,2.50
#   --fast                 -D 10 -R 2 -N 0 -L 22 -i S,0,2.50
#   --sensitive            -D 15 -R 2 -N 0 -L 22 -i S,1,1.15 (default)
#   --very-sensitive       -D 20 -R 3 -N 0 -L 20 -i S,1,0.50
#   -p/--threads <int> number of alignment threads to launch (1)
#   --reorder          force SAM output order to match order of input reads (¿?¿?)
################################################################

OUT="BOWTIE2.$OUT_PREFIX.very.fast.t$num_threads"
echo "==> Mapping $OUT"
\time ./bowtie2 --threads $num_threads --very-fast -x $index_path/HG_index_bowtie2_default/hsapiens.fa -U $dataset_path/$IN.fastq -S $results_path/$OUT.sam > $log_path/$OUT.log 2>&1

OUT="BOWTIE2.$OUT_PREFIX.default.t$num_threads"
echo "==> Mapping $OUT"
\time ./bowtie2 --threads $num_threads -x $index_path/HG_index_bowtie2_default/hsapiens.fa -U $dataset_path/$IN.fastq -S $results_path/$OUT.sam > $log_path/$OUT.log 2>&1

OUT="BOWTIE2.$OUT_PREFIX.very.sensitive.t$num_threads"
echo "==> Mapping $OUT"
\time ./bowtie2 --threads $num_threads --very-sensitive -x $index_path/HG_index_bowtie2_default/hsapiens_v37.fa -U $dataset_path/$IN.fastq -S $results_path/$OUT.sam > $log_path/$OUT.log 2>&1

#Returning to original path
cd $original_path
