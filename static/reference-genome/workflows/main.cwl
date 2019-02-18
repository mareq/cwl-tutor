#!/usr/bin/env cwl-runner

class: Workflow

cwlVersion: v1.0

requirements:
  - class: InlineJavascriptRequirement
  - class: StepInputExpressionRequirement
  - class: SubworkflowFeatureRequirement

inputs:
  - id: reference_genome_name
    type: string

outputs:
  - id: reference_genome_fa_gz_files
    type: File[]
    outputSource: download_reference_genome/reference_genome_files
    outputBinding:
      outputEval: $(self)
  - id: bowtie2_index
    type: File[]
    outputSource: build_bowtie2_index/bowtie2_index

steps:

  - id: download_reference_genome
    run: reference-genome.cwl
    in:
      - id: reference_genome_name
        source: reference_genome_name
    out:
      - id: reference_genome_files

  - id: build_bowtie2_index
    run: bowtie2-index.cwl
    in:
      - id: reference_genome_name
        source: reference_genome_name
      - id: reference_genome_files
        source: download_reference_genome/reference_genome_files
    out:
      - id: bowtie2_index


