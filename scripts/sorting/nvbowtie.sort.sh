#!/bin/bash

#SBATCH --job-name="NVBOWTIE-SORT"
#SBATCH -x huberman
#SBATCH -x robin

#SBATCH --time=10:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --mem=75GB

#SBATCH --output=../../logs/NVBOWTIE.sorting.summary.log 
#SBATCH --error=../../logs/NVBOWTIE.sorting.summary.log

source ../common.sh
source ../node_profiles.sh

IN=$1
OUT_PREFIX=$IN
TAG="NVBOWTIE"

sorting_path="../../data/sorts/$TAG"
results_path="../../data/results/$TAG"

echo "> Benchmarks for NVBOWTIE 0.9.9.3: $IN"

mkdir -p $sorting_path

OUT="$TAG.$OUT_PREFIX.very-fast.K20"
echo -n "==> Sorting $OUT ..."
profile "LANG=C grep -v ^'@' $results_path/$OUT.sam | sort -V -k 1 -t $'\t' > $sorting_path/$OUT.sam.sorted"
echo "Done"

OUT="$TAG.$OUT_PREFIX.fast.K20"
echo -n "==> Sorting $OUT ..."
profile "LANG=C grep -v ^'@' $results_path/$OUT.sam | sort -V -k 1 -t $'\t' > $sorting_path/$OUT.sam.sorted"
echo "Done"

OUT="$TAG.$OUT_PREFIX.default.K20"
echo -n "==> Sorting $OUT ..."
profile "LANG=C grep -v ^'@' $results_path/$OUT.sam | sort -V -k 1 -t $'\t' > $sorting_path/$OUT.sam.sorted"
echo "Done"

OUT="$TAG.$OUT_PREFIX.sensitive.K20"
echo -n "==> Sorting $OUT ..."
profile "LANG=C grep -v ^'@' $results_path/$OUT.sam | sort -V -k 1 -t $'\t' > $sorting_path/$OUT.sam.sorted"
echo "Done"

OUT="$TAG.$OUT_PREFIX.very-sensitive.K20"
echo -n "==> Sorting $OUT ..."
profile "LANG=C grep -v ^'@' $results_path/$OUT.sam | sort -V -k 1 -t $'\t' > $sorting_path/$OUT.sam.sorted"
echo "Done"

