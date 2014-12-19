#!/bin/bash

#SBATCH --job-name="SOAP3DP-GPU-SE"
#SBATCH --exclusive
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=62G
#SBATCH -w robin
#SBATCH --gres=gpu:1

#SBATCH --time=20:00:00
#SBATCH --partition=p_hpca4se 

#SBATCH --output=../../logs/SOAP3DP-GPU.SE.mapping.summary.log 
#SBATCH --error=../../logs/SOAP3DP-GPU.SE.mapping.summary.log

source ../common.sh
source ../node_profiles.sh

IN=$1
OUT_PREFIX=$IN
TAG="SOAP3DP-GPU"

#Changing working directory
original_path=`pwd`
mapper_path="../../software/mappers/soap3-dp-2.3.r177"
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
if [[ -n $(echo $IN | grep ".HiSeq.") ]]; then
	max_query_size="100"
fi
if [[ -n $(echo $IN | grep ".MiSeq.") ]]; then
	max_query_size="250"
fi
if [[ -n $(echo $IN | grep "l500") ]]; then
	max_query_size="500"
fi
if [[ -n $(echo $IN | grep "l1000") ]]; then
	max_query_size="1000"
fi

echo "> Benchmarks for SOAP3DP-GPU 2.3.r177: $IN"

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

profile "likwid-memsweeper"

mkdir -p $results_path
mkdir -p $log_path
#mkdir $local_path/HG_index_soap3-dp_default
#cp -R $index_path/HG_index_soap3-dp_default $local_index_path 
cp $dataset_path/$IN.fastq $local_dataset_path

# Warm up
################################################################

OUT_T1="$TAG.$OUT_PREFIX.warm.K20"
echo "==> Mapping $OUT_T1"
profile "./soap3-dp single $local_index_path/HG_index_soap3-dp_default/hsapiens_v37.fa.index $local_dataset_path/$IN.fastq -o $local_results_path/$OUT_T1.sam -L $max_query_size -c 0 > $log_path/$OUT_T1.log 2>&1"
$tools_path/SOAP3_tools/make_view_sam.sh $local_results_path/$OUT_T1.sam

# Test multi-threading
################################################################
#    -o <output file prefix> (default: queryFileName/queryBAMFileName)
#    -L <length of the longest read in the input> (default: 120)
#    -c <GPU device ID> 
################################################################

OUT_T2="$TAG.$OUT_PREFIX.default.K20"
echo "==> Mapping $OUT_T2"
profile "./soap3-dp single $local_index_path/HG_index_soap3-dp_default/hsapiens_v37.fa.index $local_dataset_path/$IN.fastq -o $local_results_path/$OUT_T2.sam -L $max_query_size -c 0 > $log_path/$OUT_T2.log 2>&1"
$tools_path/SOAP3_tools/make_view_sam.sh $local_results_path/$OUT_T2.sam

# Moving results from local storage to lustre
################################################################
mv $local_results_path/$OUT_T1.sam $results_path
mv $local_results_path/$OUT_T2.sam $results_path

#rm -Rf $local_index_path/HG_index_soap3-dp_default
rm -f $local_dataset_path/$IN.fastq

#Returning to original path
cd $original_path
