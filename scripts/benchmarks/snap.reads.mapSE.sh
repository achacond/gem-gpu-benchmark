#!/bin/bash

#SBATCH --job-name="SNAP-SE"
#SBATCH --exclusive
#SBATCH -w huberman

#SBATCH --time=4:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --mail-type=end
#SBATCH --mail-user="alejandro.chacon@uab.es"

#SBATCH --output=../../logs/SNAP.summary.log 
#SBATCH --error=../../logs/SNAP.summary.log

source ../node_profiles.sh

IN=$1
OUT_PREFIX=$IN

#Changing working directory
original_path=`pwd`
mapper_path="../../software/mappers/snap-1.0beta.50-linux"
cd $mapper_path

index_path="../../../data/indexes"
dataset_path="../../../data/datasets"
results_path="../../../data/results"
log_path="../../../logs"

indexSize="long"
if [[ -n $(echo $IN | grep ".HiSeq.") ]]; then
	indexSize="short"
fi

echo "> Benchmarks for SNAP 1.0Beta.50: $IN"


# Warm up
################################################################

OUT="SNAP.$indexSize.$OUT_PREFIX.warm.t$num_threads"
echo "==> Mapping $OUT"
\time ./snap single $index_path/HG_index_SNAP_$indexSize_reads $dataset_path/$IN.fastq -t $num_threads -h 50   -o $results_path/$OUT.sam > $log_path/$OUT.log 2>&1

# Test multi-threading
################################################################

OUT="SNAP.$indexSize.$OUT_PREFIX.h50.t$num_threads"
echo "==> Mapping $OUT"
\time ./snap single $index_path/HG_index_SNAP_$indexSize_reads $dataset_path/$IN.fastq -t $num_threads -h 50   -o $results_path/$OUT.sam > $log_path/$OUT.log 2>&1

OUT="SNAP.$indexSize.$OUT_PREFIX.default.t$num_threads"
echo "==> Mapping $OUT"
\time ./snap single $index_path/HG_index_SNAP_$indexSize_reads $dataset_path/$IN.fastq -t $num_threads -h 300  -o $results_path/$OUT.sam > $log_path/$OUT.log 2>&1

OUT="SNAP.$indexSize.$OUT_PREFIX.h1000.t$num_threads"
echo "==> Mapping $OUT"
\time ./snap single $index_path/HG_index_SNAP_$indexSize_reads $dataset_path/$IN.fastq -t $num_threads -h 1000 -o $results_path/$OUT.sam > $log_path/$OUT.log 2>&1

OUT="SNAP.$indexSize.$OUT_PREFIX.h2000.t$num_threads"
echo "==> Mapping $OUT"
\time ./snap single $index_path/HG_index_SNAP_$indexSize_reads $dataset_path/$IN.fastq -t $num_threads -h 2000 -o $results_path/$OUT.sam > $log_path/$OUT.log 2>&1

#Returning to original path
cd $original_path
