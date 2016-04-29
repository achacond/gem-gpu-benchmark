#!/bin/bash

source node_profiles.sh
source common.sh

#Changing working directory
original_path=`pwd`
scripts_path="benchmarks"
cd $scripts_path


# HiSeq Dataset - Single End
##############################

HiSeq_dataset='Sim.Illumina.l100.se'
#HiSeq_dataset='H.Sapiens.HiSeqSE.Real.10M'
#HiSeq_dataset='Sim.Illumina.l100.se H.Sapiens.HiSeqSE.Real.10M'

for fastaq_file in $HiSeq_dataset
do
	echo "Processing: $fastaq_file"
	#launch_benchmark GEM3-GPU gem.mapSE.sh $fastaq_file
	#launch_benchmark BWA bwa.mem.mapSE.sh $fastaq_file
	#launch_benchmark BOWTIE2 bowtie2.mapSE.sh $fastaq_file
	#launch_benchmark CUSHAW2 cushaw2.mapSE.sh $fastaq_file
	#launch_benchmark HPG hpg.mapSE.sh $fastaq_file
    #launch_benchmark NVBOWTIE nvbowtie.mapSE.sh $fastaq_file
	launch_benchmark SNAP snap.mapSE.sh $fastaq_file
	#launch_benchmark SOAP3DP-GPU soap3dp-gpu.mapSE.sh $fastaq_file
done

# MiSeq Dataset - Single End
##############################

MiSeq_dataset='Sim.Illumina.l250.se'
#MiSeq_dataset='H.Sapiens.MiSeqSE.Real.10M'
#MiSeq_dataset='Sim.Illumina.l250.se H.Sapiens.MiSeqSE.Real.10M'

for fastaq_file in $MiSeq_dataset
do
	echo "Processing: $fastaq_file"
	#launch_benchmark GEM3-GPU gem.mapSE.sh $fastaq_file
	#launch_benchmark BWA bwa.mem.mapSE.sh $fastaq_file
	#launch_benchmark BOWTIE2 bowtie2.mapSE.sh $fastaq_file
	#launch_benchmark CUSHAW2 cushaw2.mapSE.sh $fastaq_file
	#launch_benchmark HPG hpg.mapSE.sh $fastaq_file
	#launch_benchmark NVBOWTIE nvbowtie.mapSE.sh $fastaq_file
	launch_benchmark SNAP snap.mapSE.sh $fastaq_file
	#launch_benchmark SOAP3DP-GPU soap3dp-gpu.mapSE.sh $fastaq_file
done

# Illumina l500 Dataset - Single End
##############################

Illumina_l500_dataset='Sim.Illumina.l500.se'
#Illumina_l500_dataset='H.Sapiens.IonTorrentSE.Real.10M'
#Illumina_l500_dataset='Sim.Illumina.l500.se H.Sapiens.IonTorrentSE.Real.10M'

for fastaq_file in $Illumina_l500_dataset
do
	echo "Processing: $fastaq_file"
	#launch_benchmark GEM3-GPU gem.mapSE.sh $fastaq_file
	#launch_benchmark BWA bwa.mem.mapSE.sh $fastaq_file
	#launch_benchmark BOWTIE2 bowtie2.mapSE.sh $fastaq_file
	#launch_benchmark CUSHAW2 cushaw2.mapSE.sh $fastaq_file
	#launch_benchmark HPG hpg.mapSE.sh $fastaq_file
	#launch_benchmark NVBOWTIE nvbowtie.mapSE.sh $fastaq_file
	launch_benchmark SNAP snap.mapSE.sh $fastaq_file
	#launch_benchmark SOAP3DP-GPU soap3dp-gpu.mapSE.sh $fastaq_file
done

# Illumina l1000 Dataset - Single End
##############################

Illumina_l1000_dataset='Sim.Illumina.l1000.se'
#Illumina_l1000_dataset='H.Sapiens.MoleculoSE.Real.1M'
#Illumina_l1000_dataset='Sim.Illumina.l1000.se H.Sapiens.MoleculoSE.Real.1M'

for fastaq_file in $Illumina_l1000_dataset
do
	echo "Processing: $fastaq_file"
	#launch_benchmark GEM3-GPU gem.mapSE.sh $fastaq_file
	#launch_benchmark BWA bwa.mem.mapSE.sh $fastaq_file
	#launch_benchmark BOWTIE2 bowtie2.mapSE.sh $fastaq_file
	#launch_benchmark CUSHAW2 cushaw2.mapSE.sh $fastaq_file
	#launch_benchmark HPG hpg.mapSE.sh $fastaq_file
	#launch_benchmark NVBOWTIE nvbowtie.mapSE.sh $fastaq_file
	launch_benchmark SNAP snap.mapSE.sh $fastaq_file
	#launch_benchmark SOAP3DP-GPU soap3dp-gpu.mapSE.sh $fastaq_file
done

#Returning to original path
cd $original_path



