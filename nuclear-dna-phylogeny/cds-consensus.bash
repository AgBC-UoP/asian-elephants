#!/bin/bash
#title           :cds-consensus.bash
#description     :This script will generate consensus sequences for CDS mapping
#author		 :Shyaman Jayasundara (jmshyaman@eng.pdn.ac.lk)
#date            :11/20/2021
#usage		 :./cds-consensus.bash
#dependencies           :bcftools
#==============================================================================

for file in *.bam
do
    FNAME=${file%.bam}
    bcftools mpileup --threads 10 -Ou -f /elephant_wildlife/ref_sequences/ref_loxarf3_ensembl/Loxodonta_africana_loxAfr3_cds_all.fa $FNAME.bam | \
    bcftools call --threads 10 -Ou -mv | \
    bcftools norm --threads 10 -f /elephant_wildlife/ref_sequences/ref_loxarf3_ensembl/Loxodonta_africana_loxAfr3_cds_all.fa -Oz -o consensus/$FNAME.vcf.gz
    tabix consensus/$FNAME.vcf.gz
    bcftools consensus -f /elephant_wildlife/ref_sequences/ref_loxarf3_ensembl/Loxodonta_africana_loxAfr3_cds_all.fa consensus/$FNAME.vcf.gz -o consensus/$FNAME.fa
done