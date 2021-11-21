#!/bin/bash
#title           :consensus-genome.bash
#description     :This script will generate reference based genome assembly(fasta)
#author		 :Shyaman Jayasundara (jmshyaman@eng.pdn.ac.lk)
#date            :11/20/2021
#usage		 :./consensus-genome.bash
#dependencies           : bgzip, bcftools
#==============================================================================

bgzip -@ 36 variant/variants_q40_dp5.recode.vcf

bcftools stats variant/variants_q40_dp5.recode.vcf.gz > bcftools_stats.txt

bcftools index variant/variants_q40_dp5.recode.vcf.gz

cat /elephant_wildlife/ref_sequences/ref_dna_zoo_maximus/Elephas_maximus_HiC.fasta | bcftools consensus variant/variants_q40_dp5.recode.vcf.gz > variant/consensus.fa
