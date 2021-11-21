#!/bin/bash
#title           :trimmomatic.bash
#description     :This script will trim and filter adapters from raw WGS dataset
#author		 :Shyaman Jayasundara (jmshyaman@eng.pdn.ac.lk)
#date            :11/20/2021
#usage		 :./trimmomatic.bash
#dependencies           :Trimmomatic v0.39
#==============================================================================

trimmomatic-0.39.jar PE -threads 36 \
/elephant_wildlife/raw_seq_data/pinnawala/18160D-06-01_S12_L002_R1_001.fastq.gz \
/elephant_wildlife/raw_seq_data/pinnawala/18160D-06-01_S12_L002_R2_001.fastq.gz \
pinnawala_forward_paired.fq.gz \
pinnawala_forward_unpaired.fq.gz \
pinnawala_reverse_paired.fq.gz \
pinnawala_reverse_unpaired.fq.gz \
ILLUMINACLIP:/tools/Trimmomatic-0.39/adapters/TruSeq3-PE-2.fa:2:30:10:2:keepBothReads \
HEADCROP:1 LEADING:3 TRAILING:3 MINLEN:150 \
&> trimmomatic.log 
