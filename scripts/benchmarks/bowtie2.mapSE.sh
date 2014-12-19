#!/bin/bash

#SBATCH --job-name="BOWTIE2-SE"
#SBATCH --exclusive
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=62G
#SBATCH -w robin

#SBATCH --time=20:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --output=../../logs/BOWTIE2.SE.mapping.summary.log 
#SBATCH --error=../../logs/BOWTIE2.SE.mapping.summary.log

source ../common.sh
source ../node_profiles.sh

IN=$1
OUT_PREFIX=$IN
TAG="BOWTIE2"

#Changing working directory
original_path=`pwd`
mapper_path="../../software/mappers/bowtie2-2.2.3"
cd $mapper_path

index_path="../../../data/indexes"
dataset_path="../../../data/datasets"
results_path="../../../data/results/$TAG"
log_path="../../../logs/$TAG"
tools_path="../../../software/tools"

local_dataset_path="/tmp/data/datasets"
local_index_path="/tmp/data/indexes"
local_results_path="/tmp/data/results"

echo "> Benchmarks for BOWTIE2 2.2.3: $IN"

#$tools_path/FFC/flush_file $local_index_path/HG_index_bowtie2_default/hsapiens.1.bt2
#$tools_path/FFC/flush_file $local_index_path/HG_index_bowtie2_default/hsapiens.2.bt2
#$tools_path/FFC/flush_file $local_index_path/HG_index_bowtie2_default/hsapiens.3.bt2
#$tools_path/FFC/flush_file $local_index_path/HG_index_bowtie2_default/hsapiens.4.bt2
#$tools_path/FFC/flush_file $local_index_path/HG_index_bowtie2_default/hsapiens.rev.1.bt2
#$tools_path/FFC/flush_file $local_index_path/HG_index_bowtie2_default/hsapiens.rev.2.bt2

#$tools_path/FFC/flush_file $local_dataset_path/$IN.fastq

profile "likwid-memsweeper"

mkdir -p $results_path
mkdir -p $log_path
#mkdir $local_path/HG_index_bowtie2_default
#cp -R $index_path/HG_index_bowtie2_default $local_index_path 
cp $dataset_path/$IN.fastq $local_dataset_path

# Warm up
################################################################

OUT_T1="$TAG.$OUT_PREFIX.warm.t$num_threads"
echo "==> Mapping $OUT_T1"
profile "./bowtie2 --threads $num_threads -x $local_index_path/HG_index_bowtie2_default/hsapiens -U $local_dataset_path/$IN.fastq -S $local_results_path/$OUT_T1.sam > $log_path/$OUT_T1.log 2>&1"


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

OUT_T2="$TAG.$OUT_PREFIX.very.fast.t$num_threads"
echo "==> Mapping $OUT_T2"
profile "./bowtie2 --threads $num_threads --very-fast -x $local_index_path/HG_index_bowtie2_default/hsapiens -U $local_dataset_path/$IN.fastq -S $local_results_path/$OUT_T2.sam > $log_path/$OUT_T2.log 2>&1"

OUT_T3="$TAG.$OUT_PREFIX.default.t$num_threads"
echo "==> Mapping $OUT_T3"
profile "./bowtie2 --threads $num_threads -x $local_index_path/HG_index_bowtie2_default/hsapiens -U $local_dataset_path/$IN.fastq -S $local_results_path/$OUT_T3.sam > $log_path/$OUT_T3.log 2>&1"

OUT_T4="$TAG.$OUT_PREFIX.very.sensitive.t$num_threads"
echo "==> Mapping $OUT_T4"
profile "./bowtie2 --threads $num_threads --very-sensitive -x $local_index_path/HG_index_bowtie2_default/hsapiens -U $local_dataset_path/$IN.fastq -S $local_results_path/$OUT_T4.sam > $log_path/$OUT_T4.log 2>&1"

# Moving results from local storage to lustre
################################################################
mv $local_results_path/$OUT_T1.sam $results_path
mv $local_results_path/$OUT_T2.sam $results_path
mv $local_results_path/$OUT_T3.sam $results_path
mv $local_results_path/$OUT_T4.sam $results_path

#rm -Rf $local_index_path/HG_index_bowtie2_default
rm -f $local_dataset_path/$IN.fastq

#Returning to original path
cd $original_path
