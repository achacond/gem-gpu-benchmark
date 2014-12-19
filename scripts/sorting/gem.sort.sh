#!/bin/bash

#SBATCH --job-name="GEM3-GPU-SORT"
#SBATCH -x huberman
#SBATCH -x robin

#SBATCH --time=10:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --mem=75GB

#SBATCH --output=../../logs/GEM.sorting.summary.log 
#SBATCH --error=../../logs/GEM.sorting.summary.log

source ../common.sh
source ../node_profiles.sh

IN=$1
OUT_PREFIX=$IN
TAG="GEM3-GPU"

sorting_path="../../data/sorts/$TAG"
results_path="../../data/results/$TAG"

echo "> Benchmarks for GEM-GPU (git): $IN"

mkdir -p $sorting_path

OUT="$TAG.$OUT_PREFIX.t12"
echo -n "==> Sorting $OUT ..."
profile "LANG=C grep -v ^'@' $results_path/$OUT.sam | sort -V -k 1 -t $'\t' > $sorting_path/$OUT.sam.sorted"
echo "Done"

OUT="$TAG.$OUT_PREFIX.t12.K20"
echo -n "==> Sorting $OUT ..."
profile "LANG=C grep -v ^'@' $results_path/$OUT.sam | sort -V -k 1 -t $'\t' > $sorting_path/$OUT.sam.sorted"
echo "Done"
