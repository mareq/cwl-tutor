#!/usr/bin/env cwl-runner

class: Workflow

cwlVersion: v1.0

requirements:
  - class: InlineJavascriptRequirement
  - class: StepInputExpressionRequirement

inputs:
  - id: reference_genome_name
    type: string

outputs:
  - id: reference_genome_files
    type: File[]
    outputSource: wget_reference_genome/downloaded_files

steps:
  - id: wget_reference_genome
    run: ../../../workflows/tools/wget/main.cwl
    in:
      - id: name
        source: reference_genome_name
        valueFrom: $(inputs.name + "-wget")
      - id: url
        source: reference_genome_name
        valueFrom: $("ftp://hgdownload.cse.ucsc.edu/goldenPath/" + inputs.url + "/chromosomes/*")
    out:
      - id: downloaded_files
      - id: stdout
      - id: stderr


