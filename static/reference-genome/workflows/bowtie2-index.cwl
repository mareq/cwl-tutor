#!/usr/bin/env cwl-runner

class: Workflow

cwlVersion: v1.0

requirements:
  - class: InlineJavascriptRequirement
  - class: StepInputExpressionRequirement
  - class: ScatterFeatureRequirement
  - class: SubworkflowFeatureRequirement

inputs:
  - id: reference_genome_name
    type: string
  - id: reference_genome_files
    type: File[]

outputs:
  - id: bowtie2_index
    type: File[]
    outputSource: build_bowtie2_index/index

steps:

  - id: filter_fa_gz_files
    run:
      class: ExpressionTool
      cwlVersion: v1.0
      requirements:
        - class: InlineJavascriptRequirement
      expression: >
        ${
          console.log(inputs.input_files);
          var filtered_files = inputs.input_files.filter(
            (f) => f.basename.endsWith('.fa.gz')
          );
          return { filtered_files };
        }
      inputs:
        - id: input_files
          type: File[]
      outputs:
        - id: filtered_files
          type: File[]
    in:
      - id: input_files
        source: reference_genome_files
    out:
      - id: filtered_files

  - id: gunzip_fa_gz_files
    scatter: reference_genome_fa_gz_file
    in:
      - id: reference_genome_fa_gz_file
        source: filter_fa_gz_files/filtered_files
    out:
      - id: reference_genome_fa_file_array
    run:
      class: Workflow
      inputs:
        - id: reference_genome_fa_gz_file
          type: File
      outputs:
        - id: reference_genome_fa_file_array
          type: File
          outputSource: gunzip_reference_genome_fa_file/gunzipped_file
      steps:
        - id: gunzip_reference_genome_fa_file
          run: ../../../workflows/tools/gunzip/main.cwl
          in:
            - id: gzipped_file
              source: reference_genome_fa_gz_file
          out:
            - id: gunzipped_file
            - id: stdout
            - id: stderr

  - id: concat_fa_files
    run: ../../../workflows/tools/cat/main.cwl
    in:
      - id: input_files
        source: gunzip_fa_gz_files/reference_genome_fa_file_array
      - id: output_file_name
        source: reference_genome_name
        valueFrom: $(inputs.output_file_name + ".fa")
    out:
      - id: output_file
      - id: stderr

  - id: build_bowtie2_index
    run: ../../../workflows/tools/bowtie2/build_index.cwl
    in:
      - id: name
        source: reference_genome_name
        valueFrom: $("bowtie2-index_" + inputs.name)
      - id: reference_genome
        source: concat_fa_files/output_file
      - id: index_base
        source: reference_genome_name
    out:
      - id: index
      - id: stdout
      - id: stderr


