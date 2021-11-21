#!/bin/bash
#title           :clean-radseq.bash
#description     :This script will preprocess radseq data
#author		 :Shyaman Jayasundara (jmshyaman@eng.pdn.ac.lk)
#date            :11/20/2021
#usage		 :./clean-radseq.bash
#dependencies           : Stacks
#==============================================================================

process_radtags -P -p /elephant_wildlife/raw_seq_data/ddRAD_our/SphI-EcoRI_latest/tot/ -o ./cleaned_1 -c -q -r --renz_1 sphI --renz_2 ecoRI
