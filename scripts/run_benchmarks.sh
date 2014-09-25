#!/bin/bash

#Changing working directory
original_path=`pwd`
scripts_path="benchmarks"
cd $scripts_path

# HiSeq Dataset - Single End
##############################

HiSeq_dataset='H.Sapiens.HiSeq.Sim.1M H.Sapiens.HiSeq.Real.1M'

for fastaq_file in $HiSeq_dataset
do
	./gem.mapSE.sh $fastaq_file
	./bwa.mem.mapSE.sh $fastaq_file
	./bowtie2.mapSE.sh $fastaq_file
	./snap.short.reads.mapSE.sh $fastaq_file
done

#Returning to original path
cd $original_path



