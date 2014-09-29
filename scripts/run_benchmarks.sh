#!/bin/bash

binary_launcher="bash"
if [[ -n $(hostname | grep aopccuda) ]]; then
	binary_launcher="bash"
fi

if [[ -n $(hostname | grep huberman) ]]; then
	binary_launcher="sbatch"
fi

#Changing working directory
original_path=`pwd`
scripts_path="benchmarks"
cd $scripts_path

# HiSeq Dataset - Single End
##############################

HiSeq_dataset='H.Sapiens.HiSeq.Sim.1M H.Sapiens.HiSeq.Real.1M'

for fastaq_file in $HiSeq_dataset
do
	binary_launcher gem.mapSE.sh $fastaq_file
	binary_launcher bwa.mem.mapSE.sh $fastaq_file
	binary_launcher bowtie2.mapSE.sh $fastaq_file
	binary_launcher snap.short.reads.mapSE.sh $fastaq_file
done

#Returning to original path
cd $original_path



