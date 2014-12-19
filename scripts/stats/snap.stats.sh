#!/bin/bash

#SBATCH --job-name="SNAP-STATS"
#SBATCH --exclusive
#SBATCH -x huberman
#SBATCH -x robin

#SBATCH --time=20:00:00
#SBATCH --partition=p_hpca4se

#SBATCH --output=../../logs/SNAP.stats.summary.log 
#SBATCH --error=../../logs/SNAP.stats.summary.log

source ../common.sh
source ../node_profiles.sh

IN=$1
OUT_PREFIX=$IN
TAG="SNAP"

indexSize="long"
if [[ -n $(echo $IN | grep ".HiSeq.") ]]; then
	indexSize="short"
fi

#Changing working directory
original_path=`pwd`
gt_path="../../software/tools/GEMTools.Dev/bin"
cd $gt_path

sorting_path="../../../../data/sorts/$TAG"
stats_path="../../../../data/stats/$TAG"

echo "> Benchmarks for SNAP 1.0Beta.50: $IN"

mkdir -p $stats_path

OUT="$TAG.$indexSize.$OUT_PREFIX.h50.t12"
echo -n "==> Stats of $OUT ..."
profile "./gt.stats -a -i $sorting_path/$OUT.sam.sorted -t $num_threads > $stats_path/$OUT.sam.stats"
echo "Done"

OUT="$TAG.$indexSize.$OUT_PREFIX.default.t12"
echo -n "==> Stats of $OUT ..."
profile "./gt.stats -a -i $sorting_path/$OUT.sam.sorted -t $num_threads > $stats_path/$OUT.sam.stats"
echo "Done"

OUT="$TAG.$indexSize.$OUT_PREFIX.h1000.t12"
echo -n "==> Stats of $OUT ..."
profile "./gt.stats -a -i $sorting_path/$OUT.sam.sorted -t $num_threads > $stats_path/$OUT.sam.stats"
echo "Done"

OUT="$TAG.$indexSize.$OUT_PREFIX.h2000.t12"
echo -n "==> Stats of $OUT ..."
profile "./gt.stats -a -i $sorting_path/$OUT.sam.sorted -t $num_threads > $stats_path/$OUT.sam.stats"
echo "Done"



#Returning to original path
cd $original_path

