#!/usr/bin/env nextflow
// title           :bowtie2ref.nf
// description     :This script will map radseq to asian elephant reference and alignment stats will produced
// author		 :Shyaman Jayasundara (jmshyaman@eng.pdn.ac.lk)
// date            :11/20/2021
// usage		 : nextflow bowtie2ref.nf
// dependencies           :Nextflow, bwa-mem, Picard
// ==============================================================================

params.reads = "/elephant_wildlife/ddrad/ddrad_our_new_combination/cleaned_1/*_R{1,2}_*.fq.gz"
params.outdir = "$launchDir"
params.reference = "/elephant_wildlife/ref_sequences/ref_dna_zoo_maximus/Elephas_maximus_HiC.fasta"

Channel
  .fromFilePairs( params.reads )
  .ifEmpty { error "Oops! Cannot find any file matching: ${params.reads}"  }
  .set { read_pairs_ch }


process mapping {
    tag "$pair_id"
    publishDir "${params.outdir}/bowtie2_bam_1/", mode:'copy', pattern: '*.bam'

    cpus 8
    maxForks 3

    input:
    set pair_id, file(reads) from read_pairs_ch

    output:
    file '*.bam' into bam2
     
    script:
    """
         bowtie2 \\
            --threads $task.cpus \\
            -x  ${params.reference}\\
            -1 ${reads[0]} -2 ${reads[1]} \\
            -p 8 |
            samtools view -@ 4 -Sb - |
            samtools sort --threads 4 > ${pair_id}.bam
    """
}



process map_stats {
    publishDir "${params.outdir}/bowtie2_bam_1/", mode:'copy', pattern: '*_stats.txt'

    input:
    file(bam) from bam2

    output:
    file '*_stats.txt' into stat_out

    script:
    """
    java -jar /tools/picard.jar CollectAlignmentSummaryMetrics -R /elephant_wildlife/ref_sequences/ref_dna_zoo_maximus/Elephas_maximus_HiC.fasta -I $bam -O ${bam.simpleName}_stats.txt
    """
}

workflow.onComplete { 
	log.info( workflow.success ? "\nDone! Your files can be found in $launchDir/bam/\n" : "Oops .. something went wrong" )
}