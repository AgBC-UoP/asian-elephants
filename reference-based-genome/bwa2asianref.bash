#!/bin/bash
#title           :bwa2asianref.bash
#description     :This script will map reads to asian elephant reference genome and duplicate reads will be marked
#author		 :Shyaman Jayasundara (jmshyaman@eng.pdn.ac.lk)
#date            :11/20/2021
#usage		 :./bwa2asianref.bash
#dependencies           : bwa, samtools, picard
#==============================================================================

set -euf -o pipefail

mkdir -p mapping

bwa mem -R '@RG\tID:18160D\tSM:Kadol\tLB:library1' \
-M -t 36 \
/elephant_wildlife/ref_sequences/ref_dna_zoo_maximus/Elephas_maximus_HiC.fasta \
/elephant_wildlife/raw_seq_data/pinnawala/pinnawala_forward_paired.fq.gz \
/elephant_wildlife/raw_seq_data/pinnawala/pinnawala_reverse_paired.fq.gz | \
samtools fixmate -m -@ 2 - - | samtools sort -@ 8 - -o mapping/out.bam

java -Xmx80g -jar /tools/picard.jar MarkDuplicates -I mapping/out.bam -O mapping/out_markdup.bam -M mapping/out_metrics.txt --CREATE_INDEX true --REMOVE_DUPLICATES

samtools coverage mapping/out_markdup.bam -o coverage_stats.txt