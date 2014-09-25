#!/bin/bash

#Changing working directory
original_path=`pwd`
scripts_path="index"
cd $scripts_path

# Building indexes
####################

echo "Queuing GEM-GPU indexing job ..."
sbatch gen_index_GEM-GPU_profile_default.sub

echo "Queuing BWA indexing job ..."
sbatch gen_index_BWA_default.sub

echo "Queuing Bowtie2 indexing job ..."
sbatch gen_index_bowtie2_default.sub

echo "Queuing Cushaw2-GPU indexing job ..."
sbatch gen_index_cushaw2-gpu_default.sub

echo "Queuing HPG-Aligner indexing job ..."
sbatch gen_index_hpg-aligner_default.sub

echo "Queuing nvBowtie indexing job ..."
sbatch gen_index_nvbowtie_default.sub

echo "Queuing SNAP long-reads indexing job ..."
sbatch gen_index_SNAP_long_reads.sub

echo "Queuing SNAP short-reads indexing job ..."
sbatch gen_index_SNAP_short_reads.sub

echo "Queuing SOAP3-dp-GPU indexing job ..."
sbatch gen_index_soap3-dp_default.sub

#Returning to original path
cd $original_path
