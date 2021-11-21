#!/usr/bin/env nextflow
// title           :bwamap2mt.nf
// description     :This script will map WGS datasets to the E. maximus reference genome (NC_005129)
// author		 :Shyaman Jayasundara (jmshyaman@eng.pdn.ac.lk)
// date            :11/20/2021
// usage		 : nextflow bwamap2mt.nf
// dependencies           :Nextflow, bwa-mem
// ==============================================================================

params.reads = "/elephant_wildlife/raw_seq_data/**/*_{1,2}.fastq.gz"
params.outdir = "$launchDir/genemap-out"
params.reference = "/elephant_wildlife/ref_sequences/MT/NC_005129.fasta"


Channel.fromPath(params.reference)
    .into {fasta_ch}
Channel
  .fromFilePairs( params.reads )
  .ifEmpty { error "Oops! Cannot find any file matching: ${params.reads}"  }
  .set { read_pairs_ch }


process index {

  input:
  file reference from fasta_ch

  output:
  file "*" into index_ch

  script:
  """
  bwa index $reference
  """
      }


process mapping {
    tag "$pair_id ${index.simpleName.first()}"
    publishDir "${params.outdir}/${index.simpleName.first()}", mode:'copy', pattern: '*.sam'
    publishDir "${params.outdir}/${index.simpleName.first()}/logs", mode:'copy', pattern: '*.log'

    cpus 24
    maxForks 1

    input:
    file index from index_ch.first()
    set pair_id, file(reads) from read_pairs_ch

    output:
    file '*.sam' into sam
    file "${index.simpleName.first()}_${pair_id}.log" into logs
     
    script:
    """
        bwa mem \
        -M -t $task.cpus \
        ${index.simpleName.first()}.fa \
        ${reads[0]} \
        ${reads[1]} | \
        samtools view -h -F 4 | samtools sort -@ 8 -o ${index.simpleName.first()}_${pair_id}.sam \\
            2>&1 | tee ${index.simpleName.first()}_${pair_id}.log
    """
}


workflow.onComplete { 
	log.info( workflow.success ? "\nDone! Your files can be found in $launchDir/nf-out\n" : "Oops .. something went wrong" )
}