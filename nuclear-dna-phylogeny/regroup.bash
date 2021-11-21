#!/bin/bash
#title           :regroup.bash
#description     :This script will split and regroup cds consensus sequences
#author		 :Shyaman Jayasundara (jmshyaman@eng.pdn.ac.lk)
#date            :11/20/2021
#usage		 :./regroup.bash
#dependencies           :
#==============================================================================

# genewise consensus sequence split

for i in `ls consensus/*.fa`; do
    s=${i##*/}
    fn=${s%.fa}
    # mkdir -p genes/$fn
    awk -F " "  '{if($1~">"){print $1} else {print $0}}' $i | sed 's/>.*/&_'"$fn"'/' | awk -F '>' '/^>/ { name=$0;  gsub(/[_].*/,"",$2); F=sprintf("genes/%s/'$fn'.fasta",$2); print name > F ;next;} {print >> F; close(F)}'
done

# concat genewise sequences from each library

for i in `ls genes`; do
    cat genes/$i/*.fasta > genes/all/$i.fasta
done


