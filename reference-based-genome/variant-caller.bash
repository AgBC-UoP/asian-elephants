#!/bin/bash
#title           :variant-caller.bash
#description     :This script will call variants
#author		 :Shyaman Jayasundara (jmshyaman@eng.pdn.ac.lk)
#date            :11/20/2021
#usage		 :./variant-caller.bash
#dependencies           : freebayes
#==============================================================================

mkdir -p variant
ulimit -s 81920

freebayes-parallel <(/tools/freebayes/scripts/fasta_generate_regions.py /elephant_wildlife/ref_sequences/ref_dna_zoo_maximus/Elephas_maximus_HiC.fasta 1000000) 36 \
    -f /elephant_wildlife/ref_sequences/ref_dna_zoo_maximus/Elephas_maximus_HiC.fasta mapping/out_markdup.bam > variant/variants.vcf
