#!/bin/bash

source node_profiles.sh
source common.sh

#Changing working directory
original_path=`pwd`
scripts_path="stats"
cd $scripts_path


# HiSeq Dataset - Single End
##############################

#HiSeq_dataset='H.Sapiens.HiSeqSE.Sim.10M'
#HiSeq_dataset='H.Sapiens.HiSeqSE.Real.10M'
HiSeq_dataset='H.Sapiens.HiSeqSE.Sim.10M H.Sapiens.HiSeqSE.Real.10M'

for fastaq_file in $HiSeq_dataset
do
	echo "Processing stats of: $fastaq_file"

	# Mappers CPU
	#launch_stats GEM3-GPU gem.stats.sh $fastaq_file
	#launch_stats BWA bwa.mem.stats.sh $fastaq_file
	#launch_stats BOWTIE2 bowtie2.stats.sh $fastaq_file
	#launch_stats HPG hpg.stats.sh $fastaq_file
	#launch_stats SNAP snap.stats.sh $fastaq_file

	# Mappers GPU
	#launch_stats CUSHAW2 cushaw2.stats.sh $fastaq_file
	#launch_stats NVBOWTIE nvbowtie.stats.sh $fastaq_file
	#launch_stats SOAP3DP-GPU soap3dp-gpu.stats.sh $fastaq_file
done

# MiSeq Dataset - Single End
##############################

#MiSeq_dataset='H.Sapiens.MiSeqSE.Sim.10M'
#MiSeq_dataset='H.Sapiens.MiSeqSE.Real.10M'
MiSeq_dataset='H.Sapiens.MiSeqSE.Sim.10M H.Sapiens.MiSeqSE.Real.10M'

for fastaq_file in $MiSeq_dataset
do
	echo "Processing stats of: $fastaq_file"

	# Mappers CPU
	#launch_stats GEM3-GPU gem.stats.sh $fastaq_file
	#launch_stats BWA bwa.mem.stats.sh $fastaq_file
	#launch_stats BOWTIE2 bowtie2.stats.sh $fastaq_file
	#launch_stats HPG hpg.stats.sh $fastaq_file
	#launch_stats SNAP snap.stats.sh $fastaq_file

	# Mappers GPU
	#launch_stats CUSHAW2 cushaw2.stats.sh $fastaq_file
	#launch_stats NVBOWTIE nvbowtie.stats.sh $fastaq_file
	#launch_stats SOAP3DP-GPU soap3dp-gpu.stats.sh $fastaq_file
done

# Illumina l500 Dataset - Single End
##############################

#Illumina_l500_dataset='H.Sapiens.Illumina.SimSE.l500'
#Illumina_l500_dataset='H.Sapiens.IonTorrentSE.Real.10M'
Illumina_l500_dataset='H.Sapiens.Illumina.SimSE.l500 H.Sapiens.IonTorrentSE.Real.10M'

for fastaq_file in $Illumina_l500_dataset
do
	echo "Processing stats of: $fastaq_file"

	# Mappers CPU
	#launch_stats GEM3-GPU gem.stats.sh $fastaq_file
	#launch_stats BWA bwa.mem.stats.sh $fastaq_file
	#launch_stats BOWTIE2 bowtie2.stats.sh $fastaq_file
	#launch_stats HPG hpg.stats.sh $fastaq_file
	#launch_stats SNAP snap.stats.sh $fastaq_file

	# Mappers GPU
	#launch_stats CUSHAW2 cushaw2.stats.sh $fastaq_file
	#launch_stats NVBOWTIE nvbowtie.stats.sh $fastaq_file
	#launch_stats SOAP3DP-GPU soap3dp-gpu.stats.sh $fastaq_file
done

# Illumina l1000 Dataset - Single End
##############################

Illumina_l1000_dataset='H.Sapiens.Illumina.SimSE.l1000'
#Illumina_l1000_dataset='H.Sapiens.MoleculoSE.Real.1M'
#Illumina_l1000_dataset='H.Sapiens.Illumina.SimSE.l1000 H.Sapiens.MoleculoSE.Real.1M'

for fastaq_file in $Illumina_l1000_dataset
do
	echo "Processing stats of: $fastaq_file"

	# Mappers CPU
	launch_stats GEM3-GPU gem.stats.sh $fastaq_file
	#launch_stats BWA bwa.mem.stats.sh $fastaq_file
	#launch_stats BOWTIE2 bowtie2.stats.sh $fastaq_file
	#launch_stats HPG hpg.stats.sh $fastaq_file
	#launch_stats SNAP snap.stats.sh $fastaq_file

	# Mappers GPU
	#launch_stats CUSHAW2 cushaw2.stats.sh $fastaq_file
	#launch_stats NVBOWTIE nvbowtie.stats.sh $fastaq_file
	#launch_stats SOAP3DP-GPU soap3dp-gpu.stats.sh $fastaq_file
done

#Returning to original path
cd $original_path



