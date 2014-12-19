#!/bin/bash

#SBATCH --job-name="SNAP-SORT"
#SBATCH -x huberman
#SBATCH -x robin

#SBATCH --time=10:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --mem=75GB

#SBATCH --output=../../logs/SNAP.sorting.summary.log 
#SBATCH --error=../../logs/SNAP.sorting.summary.log

source ../common.sh
source ../node_profiles.sh

IN=$1
OUT_PREFIX=$IN
TAG="SNAP"

indexSize="long"
if [[ -n $(echo $IN | grep ".HiSeq.") ]]; then
	indexSize="short"
fi

sorting_path="../../data/sorts/$TAG"
results_path="../../data/results/$TAG"

echo "> Benchmarks for SNAP 1.0Beta.50: $IN"

mkdir -p $sorting_path

OUT="$TAG.$indexSize.$OUT_PREFIX.h50.t12"
echo -n "==> Sorting $OUT ..."
profile "LANG=C grep -v ^'@' $results_path/$OUT.sam | sort -V -k 1 -t $'\t' > $sorting_path/$OUT.sam.sorted"
echo "Done"

OUT="$TAG.$indexSize.$OUT_PREFIX.default.t12"
echo -n "==> Sorting $OUT ..."
profile "LANG=C grep -v ^'@' $results_path/$OUT.sam | sort -V -k 1 -t $'\t' > $sorting_path/$OUT.sam.sorted"
echo "Done"

OUT="$TAG.$indexSize.$OUT_PREFIX.h1000.t12"
echo -n "==> Sorting $OUT ..."
profile "LANG=C grep -v ^'@' $results_path/$OUT.sam | sort -V -k 1 -t $'\t' > $sorting_path/$OUT.sam.sorted"
echo "Done"

OUT="$TAG.$indexSize.$OUT_PREFIX.h2000.t12"
echo -n "==> Sorting $OUT ..."
profile "LANG=C grep -v ^'@' $results_path/$OUT.sam | sort -V -k 1 -t $'\t' > $sorting_path/$OUT.sam.sorted"
echo "Done"

