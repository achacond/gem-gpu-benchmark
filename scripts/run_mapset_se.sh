#!/bin/bash

source node_profiles.sh
source common.sh

#Changing working directory
original_path=`pwd`
scripts_path="mapset"
cd $scripts_path


# HiSeq Dataset - Single End
##############################

HiSeq_dataset='H.Sapiens.HiSeqSE.Sim.10M'

for fastaq_file in $HiSeq_dataset
do
	echo "Processing mapsets: $fastaq_file"

	# Mappers CPU
	launch_mapset GEM3-GPU gem.se.mapsets.sh $fastaq_file
	#launch_mapset BWA bwa.mem.se.mapsets.sh $fastaq_file
	#launch_mapset BOWTIE2 bowtie2.se.mapsets.sh $fastaq_file
	#launch_mapset HPG hpg.se.mapsets.sh $fastaq_file
	#launch_mapset SNAP snap.se.mapsets.sh $fastaq_file

	# Mappers GPU
	#launch_mapset CUSHAW2 cushaw2.se.mapsets.sh $fastaq_file
	#launch_mapset NVBOWTIE nvbowtie.se.mapsets.sh $fastaq_file
	#launch_mapset SOAP3DP-GPU soap3dp-gpu.se.mapsets.sh $fastaq_file
done

# MiSeq Dataset - Single End
##############################

MiSeq_dataset='H.Sapiens.MiSeqSE.Sim.10M'

for fastaq_file in $MiSeq_dataset
do
	echo "Processing mapsets: $fastaq_file"

	# Mappers CPU
	launch_mapset GEM3-GPU gem.se.mapsets.sh $fastaq_file
	#launch_mapset BWA bwa.mem.se.mapsets.sh $fastaq_file
	#launch_mapset BOWTIE2 bowtie2.se.mapsets.sh $fastaq_file
	#launch_mapset HPG hpg.se.mapsets.sh $fastaq_file
	#launch_mapset SNAP snap.se.mapsets.sh $fastaq_file

	# Mappers GPU
	#launch_mapset CUSHAW2 cushaw2.se.mapsets.sh $fastaq_file
	#launch_mapset NVBOWTIE nvbowtie.se.mapsets.sh $fastaq_file
	#launch_mapset SOAP3DP-GPU soap3dp-gpu.se.mapsets.sh $fastaq_file
done

# Illumina l500 Dataset - Single End
##############################

Illumina_l500_dataset='H.Sapiens.Illumina.SimSE.l500'

for fastaq_file in $Illumina_l500_dataset
do
	echo "Processing mapsets: $fastaq_file"

	# Mappers CPU
	launch_mapset GEM3-GPU gem.se.mapsets.sh $fastaq_file
	#launch_mapset BWA bwa.mem.se.mapsets.sh $fastaq_file
	#launch_mapset BOWTIE2 bowtie2.se.mapsets.sh $fastaq_file
	#launch_mapset HPG hpg.se.mapsets.sh $fastaq_file
	#launch_mapset SNAP snap.se.mapsets.sh $fastaq_file

	# Mappers GPU
	#launch_mapset CUSHAW2 cushaw2.se.mapsets.sh $fastaq_file
	#launch_mapset NVBOWTIE nvbowtie.se.mapsets.sh $fastaq_file
	#launch_mapset SOAP3DP-GPU soap3dp-gpu.se.mapsets.sh $fastaq_file
done

# Illumina l1000 Dataset - Single End
##############################

Illumina_l1000_dataset='H.Sapiens.Illumina.SimSE.l1000'

for fastaq_file in $Illumina_l1000_dataset
do
	echo "Processing mapsets: $fastaq_file"

	# Mappers CPU
	#launch_mapset GEM3-GPU gem.se.mapsets.sh $fastaq_file
	#launch_mapset BWA bwa.mem.se.mapsets.sh $fastaq_file
	#launch_mapset BOWTIE2 bowtie2.se.mapsets.sh $fastaq_file
	#launch_mapset HPG hpg.se.mapsets.sh $fastaq_file
	#launch_mapset SNAP snap.se.mapsets.sh $fastaq_file

	# Mappers GPU
	#launch_mapset CUSHAW2 cushaw2.se.mapsets.sh $fastaq_file
	#launch_mapset NVBOWTIE nvbowtie.se.mapsets.sh $fastaq_file
	#launch_mapset SOAP3DP-GPU soap3dp-gpu.se.mapsets.sh $fastaq_file
done

#Returning to original path
cd $original_path



