#!/bin/bash
#title           :coverage-plot.R
#description     :This script will generate coverage density plot for mapping
#author		 :Shyaman Jayasundara (jmshyaman@eng.pdn.ac.lk)
#date            :11/20/2021
#usage		 :Rscript coverage-plot.R
#dependencies           :karyoploteR
#==============================================================================

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("karyoploteR")
browseVignettes("karyoploteR")

library(karyoploteR)

custom.genome <- toGRanges("/elephant_wildlife/ref_sequences/ref_dna_zoo_maximus/info.txt")

kp <- plotKaryotype(genome = custom.genome)
kpAddBaseNumbers(kp, tick.dist = 50000000, add.units = FALSE)

kpPlotBAMDensity(kp, data="/elephant_wildlife/alignment/to_dnazoo/pinnawala/mapping/out_markdup.bam")
