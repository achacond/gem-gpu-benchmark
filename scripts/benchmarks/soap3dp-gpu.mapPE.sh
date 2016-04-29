#!/bin/bash

#SBATCH --job-name="SOAP3DP-GPU-PE"
#SBATCH --exclusive
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=29900M
#SBATCH -w bane
#SBATCH --gres=gpu:2

#SBATCH --time=80:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --output=../../logs/SOAP3DP-GPU.PE.mapping.summary.log 
#SBATCH --error=../../logs/SOAP3DP-GPU.PE.mapping.summary.log

echo $CUDA_VISIBLE_DEVICES > /tmp/nvidia-reset.$SLURM_JOB_ID

source ../common.sh
source ../node_profiles.sh

IN=$1
OUT_PREFIX=$IN
TAG="SOAP3DP-GPU"

#Changing working directory
original_path=`pwd`
mapper_path="../../software/mappers/soap3-dp-2.3.r180"
cd $mapper_path

index_path="../../../data/indexes"
dataset_path="../../../data/datasets"
results_path="../../../data/results/$TAG"
log_path="../../../logs/$TAG"
tools_path="../../../software/tools"

local_dataset_path="/tmp/data/datasets"
local_index_path="/tmp/data/indexes"
local_results_path="/tmp/data/results"

max_query_size="120"
if [[ -n $(echo $IN | grep ".l100.") ]]; then
	max_query_size="100"
fi
if [[ -n $(echo $IN | grep ".l250.") ]]; then
	max_query_size="250"
fi
if [[ -n $(echo $IN | grep ".l500.") ]]; then
	max_query_size="500"
fi
if [[ -n $(echo $IN | grep ".l1000.") ]]; then
	max_query_size="1000"
fi

echo "> Benchmarks for SOAP3DP-GPU 2.3.r180: $IN"

profile "likwid-memsweeper"

#$tools_path/FFC/flush_file $local_index_path/HG_index_soap3-dp_default/hsapiens_v37.fa.index.amb
#$tools_path/FFC/flush_file $local_index_path/HG_index_soap3-dp_default/hsapiens_v37.fa.index.ann
#$tools_path/FFC/flush_file $local_index_path/HG_index_soap3-dp_default/hsapiens_v37.fa.index.bwt
#$tools_path/FFC/flush_file $local_index_path/HG_index_soap3-dp_default/hsapiens_v37.fa.index.fmv
#$tools_path/FFC/flush_file $local_index_path/HG_index_soap3-dp_default/hsapiens_v37.fa.index.fmv.gpu
#$tools_path/FFC/flush_file $local_index_path/HG_index_soap3-dp_default/hsapiens_v37.fa.index.fmv.mmap
#$tools_path/FFC/flush_file $local_index_path/HG_index_soap3-dp_default/hsapiens_v37.fa.index.lkt
#$tools_path/FFC/flush_file $local_index_path/HG_index_soap3-dp_default/hsapiens_v37.fa.index.pac
#$tools_path/FFC/flush_file $local_index_path/HG_index_soap3-dp_default/hsapiens_v37.fa.index.pac.mmap
#$tools_path/FFC/flush_file $local_index_path/HG_index_soap3-dp_default/hsapiens_v37.fa.index.rev.bwt
#$tools_path/FFC/flush_file $local_index_path/HG_index_soap3-dp_default/hsapiens_v37.fa.index.rev.fmv
#$tools_path/FFC/flush_file $local_index_path/HG_index_soap3-dp_default/hsapiens_v37.fa.index.rev.fmv.gpu
#$tools_path/FFC/flush_file $local_index_path/HG_index_soap3-dp_default/hsapiens_v37.fa.index.rev.fmv.mmap
#$tools_path/FFC/flush_file $local_index_path/HG_index_soap3-dp_default/hsapiens_v37.fa.index.rev.lkt
#$tools_path/FFC/flush_file $local_index_path/HG_index_soap3-dp_default/hsapiens_v37.fa.index.rev.pac
#$tools_path/FFC/flush_file $local_index_path/HG_index_soap3-dp_default/hsapiens_v37.fa.index.sa
#$tools_path/FFC/flush_file $local_index_path/HG_index_soap3-dp_default/hsapiens_v37.fa.index.tra

mkdir -p $results_path
mkdir -p $log_path
cp -R $index_path/HG_index_soap3-dp_default $local_index_path
cp $dataset_path/PE.DUMMY.1.fastq $local_dataset_path
cp $dataset_path/PE.DUMMY.2.fastq $local_dataset_path 
cp $dataset_path/$IN.1.fastq $local_dataset_path
cp $dataset_path/$IN.2.fastq $local_dataset_path

# Warm up
################################################################

OUT_T1="$TAG.$OUT_PREFIX.warm.K40"
echo "==> Mapping $OUT_T1"
profile "./soap3-dp pair $local_index_path/HG_index_soap3-dp_default/hsapiens_v37.fa.index $local_dataset_path/PE.DUMMY.1.fastq $local_dataset_path/PE.DUMMY.2.fastq -o $local_results_path/$OUT_T1.sam -L $max_query_size -c 0 > $log_path/$OUT_T1.log 2>&1"
$tools_path/SOAP3_tools/make_view_sam.sh $local_results_path/$OUT_T1.sam

# Test multi-threading
################################################################
#     -u <max value of insert size> (default: 500)
#     -v <min value of insert size> (default: 1)
#     -o <output file prefix> (default: queryFileName1/queryBAMFileName)
#     -L <length of the longest read in the input> (default: 120)
#     -c <GPU device ID>
################################################################

OUT_T2="$TAG.$OUT_PREFIX.default.K40"
echo "==> Mapping $OUT_T2"
profile "./soap3-dp pair $local_index_path/HG_index_soap3-dp_default/hsapiens_v37.fa.index $local_dataset_path/$IN.1.fastq $local_dataset_path/$IN.2.fastq -o $local_results_path/$OUT_T2.sam -L $max_query_size -c 0 > $log_path/$OUT_T2.log 2>&1"
$tools_path/SOAP3_tools/make_view_sam.sh $local_results_path/$OUT_T2.sam

# Moving results from local storage to lustre
################################################################
mv $local_results_path/$OUT_T1.sam $results_path
mv $local_results_path/$OUT_T2.sam $results_path

rm -Rf $local_index_path/HG_index_soap3-dp_default
rm -f $local_dataset_path/PE.DUMMY.1.fastq
rm -f $local_dataset_path/PE.DUMMY.2.fastq
rm -f $local_dataset_path/$IN.1.fastq
rm -f $local_dataset_path/$IN.2.fastq

#Returning to original path
cd $original_path
