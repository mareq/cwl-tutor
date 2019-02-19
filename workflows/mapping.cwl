#!/usr/bin/env cwl-runner

class: Workflow

cwlVersion: v1.0

requirements:
  - class: StepInputExpressionRequirement
  - class: SchemaDefRequirement
    types:
      - $import: types/fastq_pair.yml
      - $import: types/bowtie2_index.yml
  - class: ScatterFeatureRequirement
  - class: SubworkflowFeatureRequirement

inputs:
  - id: input_fastq_pairs_array
    type: types/fastq_pair.yml#fastq_pair[]
  - id: input_bowtie2_index
    type: types/bowtie2_index.yml#bowtie2_index

outputs:
  - id: bowtie2_sam_array
    type: File[]
    outputSource: subworkflow/bowtie2_sam
  - id: bowtie2_stdout_array
    type: File[]
    outputSource: subworkflow/bowtie2_stdout
  - id: bowtie2_stderr_array
    type: File[]
    outputSource: subworkflow/bowtie2_stderr

steps:

  - id: subworkflow

    scatter: input_fastq_pair

    in:
      - id: input_fastq_pair
        source: input_fastq_pairs_array
      - id: input_bowtie2_index
        source: input_bowtie2_index

    out:
      - id: bowtie2_sam
      - id: bowtie2_stdout
      - id: bowtie2_stderr

    run:

      class: Workflow

      inputs:
        - id: input_fastq_pair
          type: types/fastq_pair.yml#fastq_pair
        - id: input_bowtie2_index
          type: types/bowtie2_index.yml#bowtie2_index

      outputs:
        - id: bowtie2_sam
          type: File
          outputSource: bowtie2/output_sam
        - id: bowtie2_stdout
          type: File
          outputSource: bowtie2/stdout
        - id: bowtie2_stderr
          type: File
          outputSource: bowtie2/stderr

      steps:

        - id: get_input_fastq_pair
          run: types/get_fastq_pair.yml
          in: 
            - id: fastq_pair
              source: input_fastq_pair
          out:
            - id: sample_name
            - id: read_1
            - id: read_2

        - id: get_input_bowtie2_index
          run: types/get_bowtie2_index.yml
          in:
            - id: bowtie2_index
              source: input_bowtie2_index
          out:
            - id: directory
            - id: filename_prefix

        - id: bowtie2
          run: tools/bowtie2/paired.cwl
          in:
            - id: sample_name
              source: get_input_fastq_pair/sample_name
            - id: input_index_directory
              source: get_input_bowtie2_index/directory
            - id: input_index_filename_prefix
              source: get_input_bowtie2_index/filename_prefix
            - id: input_fastq_read_1
              source: get_input_fastq_pair/read_1
            - id: input_fastq_read_2
              source: get_input_fastq_pair/read_2
          out:
            - id: output_sam
            - id: stdout
            - id: stderr


