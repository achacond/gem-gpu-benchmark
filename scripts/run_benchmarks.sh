#!/bin/bash

source node_profiles.sh
source common.sh

#Changing working directory
original_path=`pwd`
scripts_path="benchmarks"
cd $scripts_path


# HiSeq Dataset - Single End
##############################

HiSeq_dataset='H.Sapiens.HiSeqSE.Sim.10M'

#for fastaq_file in $HiSeq_dataset
#do
	#launch_benchmark GEM gem.mapSE.sh $fastaq_file
	#launch_benchmark BWA bwa.mem.mapSE.sh $fastaq_file
	#launch_benchmark BOWTIE2 bowtie2.mapSE.sh $fastaq_file
	#launch_benchmark SNAP snap.short.reads.mapSE.sh $fastaq_file
#done

# MiSeq Dataset - Single End
##############################

MiSeq_dataset='H.Sapiens.MiSeqSE.Sim.10M'

for fastaq_file in $MiSeq_dataset
do
	#launch_benchmark GEM gem.mapSE.sh $fastaq_file
	launch_benchmark BWA bwa.mem.mapSE.sh $fastaq_file
	#launch_benchmark BOWTIE2 bowtie2.mapSE.sh $fastaq_file
	#launch_benchmark SNAP snap.long.reads.mapSE.sh $fastaq_file
done

#Returning to original path
cd $original_path



