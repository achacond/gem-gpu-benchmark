#!/bin/bash

source node_profiles.sh
source common.sh

#Changing working directory
original_path=`pwd`
scripts_path="mapset"
cd $scripts_path


# HiSeq Dataset - Single End
##############################

HiSeq_dataset='H.Sapiens.HiSeqPE.Sim.10M'

for fastaq_file in $HiSeq_dataset
do
	echo "Processing mapsets: $fastaq_file"

	# Mappers CPU
	#launch_mapset GEM3-GPU gem.pe.mapsets.sh $fastaq_file
	#launch_mapset BWA bwa.mem.pe.mapsets.sh $fastaq_file
	#launch_mapset BOWTIE2 bowtie2.pe.mapsets.sh $fastaq_file
	#launch_mapset HPG hpg.pe.mapsets.sh $fastaq_file
	#launch_mapset SNAP snap.pe.mapsets.sh $fastaq_file

	# Mappers GPU
	#launch_mapset CUSHAW2 cushaw2.pe.mapsets.sh $fastaq_file
	#launch_mapset NVBOWTIE nvbowtie.pe.mapsets.sh $fastaq_file
	#launch_mapset SOAP3DP-GPU soap3dp-gpu.pe.mapsets.sh $fastaq_file
done

# MiSeq Dataset - Single End
##############################

MiSeq_dataset='H.Sapiens.MiSeqPE.Sim.10M'

for fastaq_file in $MiSeq_dataset
do
	echo "Processing mapsets: $fastaq_file"

	# Mappers CPU
	launch_mapset GEM3-GPU gem.pe.mapsets.sh $fastaq_file
	#launch_mapset BWA bwa.mem.pe.mapsets.sh $fastaq_file
	#launch_mapset BOWTIE2 bowtie2.pe.mapsets.sh $fastaq_file
	#launch_mapset HPG hpg.pe.mapsets.sh $fastaq_file
	#launch_mapset SNAP snap.pe.mapsets.sh $fastaq_file

	# Mappers GPU
	#launch_mapset CUSHAW2 cushaw2.pe.mapsets.sh $fastaq_file
	#launch_mapset NVBOWTIE nvbowtie.pe.mapsets.sh $fastaq_file
	#launch_mapset SOAP3DP-GPU soap3dp-gpu.pe.mapsets.sh $fastaq_file
done



