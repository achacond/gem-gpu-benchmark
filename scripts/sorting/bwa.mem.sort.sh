#!/bin/bash

#SBATCH --job-name="BWA-SORT"
#SBATCH -x huberman
#SBATCH -x robin

#SBATCH --time=10:00:00
#SBATCH --partition=p_hpca4se

#SBATCH --mem=75GB

#SBATCH --output=../../logs/BWA.sorting.summary.log 
#SBATCH --error=../../logs/BWA.sorting.summary.log

source ../common.sh
source ../node_profiles.sh

IN=$1
OUT_PREFIX=$IN
TAG="BWA"

sorting_path="../../data/sorts/$TAG"
results_path="../../data/results/$TAG"

echo "> Benchmarks for BWA 0.7.10: $IN"

mkdir -p $sorting_path

OUT="$TAG.$OUT_PREFIX.default.t12"
echo "==> Sorting $OUT ..."
profile "LANG=C grep -v ^'@' $results_path/$OUT.sam | sort -V -k 1 -t $'\t' > $sorting_path/$OUT.sam.sorted"
echo "Done"

OUT="$TAG.$OUT_PREFIX.c500.t12"
echo "==> Sorting $OUT ..."
profile "LANG=C grep -v ^'@' $results_path/$OUT.sam | sort -V -k 1 -t $'\t' > $sorting_path/$OUT.sam.sorted"
echo "Done"

OUT="$TAG.$OUT_PREFIX.c1000.t12"
echo "==> Sorting $OUT ..."
profile "LANG=C grep -v ^'@' $results_path/$OUT.sam | sort -V -k 1 -t $'\t' > $sorting_path/$OUT.sam.sorted"
echo "Done"

OUT="$TAG.$OUT_PREFIX.c16000.t12"
echo "==> Sorting $OUT ..."
profile "LANG=C grep -v ^'@' $results_path/$OUT.sam | sort -V -k 1 -t $'\t' > $sorting_path/$OUT.sam.sorted"
echo "Done"

OUT="$TAG.$OUT_PREFIX.c20000.k16.t12"
echo "==> Sorting $OUT ..."
profile "LANG=C grep -v ^'@' $results_path/$OUT.sam | sort -V -k 1 -t $'\t' > $sorting_path/$OUT.sam.sorted"
echo "Done"

