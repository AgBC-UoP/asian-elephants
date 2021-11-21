#!/bin/bash
#title           :ref-rad-analysis.bash
#description     :This script will run stacks pipeline and calculate stats on the results
#author		 :Shyaman Jayasundara (jmshyaman@eng.pdn.ac.lk)
#date            :11/20/2021
#usage		 :./ref-rad-analysis.bash
#dependencies           : Stacks
#==============================================================================

mkdir -p stacks.ref1

gstacks -I "/elephant_wildlife/ddrad/ddrad_our_new_combination/bowtie2_bam_2" -M "/elephant_wildlife/ddrad/ddrad_our_new_combination/info/popmap_single.tsv" -O "/elephant_wildlife/ddrad/ddrad_our_new_combination/stacks.ref_1/" -t 20 --min-mapq 20

populations -P "/elephant_wildlife/ddrad/ddrad_our_new_combination/stacks.ref_1/" -t 20 --structure --phylip-var --treemix -M "/elephant_wildlife/ddrad/ddrad_our_new_combination/info/popmap_single.tsv" -r 0.80 --genepop --fasta-loci --fasta-samples --smooth --vcf --hwe --min-maf 0.05 --ordered-export

# SNP counts for each locus
cat stacks.ref_1/populations.sumstats.tsv | grep -v "^#" | cut -f 1,5| sort -n | uniq -c | sed -E 's/^ +([0-9]+).([0-9]+).1/\1\t\2/' > stacks.ref_1/SNPs.txt

# calculate lengths of loci
awk '/^>/ {if (seqlen){print seqlen}; print ;seqlen=0;next; } { seqlen += length($0)}END{print seqlen}' stacks.ref_1/populations.loci.fa > stacks.ref_1/populations.loci.len

# number of polymorphic loci
cat tacks.ref_1/populations.hapstats.tsv | grep -v "^#" | wc -l > poly.txt

# run without the sample B_MAD
populations -P "/elephant_wildlife/ddrad/ddrad_our_new_combination/stacks.ref_1/" -t 20 --structure --phylip-var --treemix -M "/elephant_wildlife/ddrad/ddrad_our_new_combination/info/popmap_single_exclude24.tsv" -r 0.80 --genepop --fasta-loci --fasta-samples --smooth --vcf --hwe --min-maf 0.05 --ordered-export -O "/elephant_wildlife/ddrad/ddrad_our_new_combination/stacks.ref_1/exclude24"

cat stacks.ref_1/exclude24/populations.sumstats.tsv | grep -v "^#" | cut -f 1,5| sort -n | uniq -c | sed -E 's/^ +([0-9]+).([0-9]+).1/\1\t\2/' > stacks.ref_1/exclude24/SNPs.txt