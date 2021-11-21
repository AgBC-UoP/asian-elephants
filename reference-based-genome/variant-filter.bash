#!/bin/bash
#title           :variant-filter.bash
#description     :This script will filter variants from vcf file
#author		 :Shyaman Jayasundara (jmshyaman@eng.pdn.ac.lk)
#date            :11/20/2021
#usage		 :./variant-filter.bash
#dependencies           :vcftools
#==============================================================================

vcftools --vcf variant/variants.vcf --minQ 40 --minDP 5 --maxDP 50 --recode --recode-INFO-all --out variant/variants_q40_dp5 &> variant-filter.log