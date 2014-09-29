#!/bin/bash

#Changing working directory
original_path=`pwd`
scripts_path="index"
cd $scripts_path

binary_launcher="bash"
if [[ -n $(hostname | grep aopccuda) ]]; then
	binary_launcher="bash"
fi

if [[ -n $(hostname | grep huberman) ]]; then
	binary_launcher="sbatch"
fi

# Building indexes
####################

echo "Launching GEM-GPU indexing job ..."
binary_launcher gen_index_GEM-GPU_profile_default.sub

echo "Launching BWA indexing job ..."
binary_launcher gen_index_BWA_default.sub

echo "Launching Bowtie2 indexing job ..."
binary_launcher gen_index_bowtie2_default.sub

echo "Launching Cushaw2-GPU indexing job ..."
binary_launcher gen_index_cushaw2-gpu_default.sub

echo "Launching HPG-Aligner indexing job ..."
binary_launcher gen_index_hpg-aligner_default.sub

echo "Launching nvBowtie indexing job ..."
binary_launcher gen_index_nvbowtie_default.sub

echo "Launching SNAP long-reads indexing job ..."
binary_launcher gen_index_SNAP_long_reads.sub

echo "Launching SNAP short-reads indexing job ..."
binary_launcher gen_index_SNAP_short_reads.sub

echo "Launching SOAP3-dp-GPU indexing job ..."
binary_launcher gen_index_soap3-dp_default.sub

#Returning to original path
cd $original_path
