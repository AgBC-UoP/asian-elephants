#!/bin/bash
#title           :sample-reads.bash
#description     :This script will extract ~5GB data from raw WGS dataset
#author		 :Shyaman Jayasundara (jmshyaman@eng.pdn.ac.lk)
#date            :11/20/2021
#usage		 :./sample-reads.bash
#dependencies           :BBMap 
#==============================================================================

reformat.sh in1=/elephant_wildlife/raw_seq_data/pinnawala/18160D-06-01_S12_L002_R1_001.fastq.gz in2=/elephant_wildlife/raw_seq_data/pinnawala/18160D-06-01_S12_L002_R2_001.fastq.gz \ 
out1=subsamp_data/subsampled.1.fastq.gz out2=subsamp_data/subsampled.2.fastq.gz samplerate=0.15 sampleseed=325
