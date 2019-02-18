#!/usr/bin/env cwl-runner

class: Workflow

cwlVersion: v1.0

requirements:
  - class: InlineJavascriptRequirement
  - class: StepInputExpressionRequirement
  - class: SchemaDefRequirement
    types:
      - $import: types/fastq_pair.yml
  - class: ScatterFeatureRequirement
  - class: SubworkflowFeatureRequirement
  - class: MultipleInputFeatureRequirement

inputs:
  - id: input_fastq_pairs_array
    type: types/fastq_pair.yml#fastq_pair[]

outputs:

  - id: fastqc_read_1_original_report_zip_array
    type: File[]
    outputSource: subworkflow/fastqc_read_1_original_report_zip
  - id: fastqc_read_1_original_report_html_array
    type: File[]
    outputSource: subworkflow/fastqc_read_1_original_report_html
  - id: fastqc_read_1_original_stdout_array
    type: File[]
    outputSource: subworkflow/fastqc_read_1_original_stdout
  - id: fastqc_read_1_original_stderr_array
    type: File[]
    outputSource: subworkflow/fastqc_read_1_original_stderr

  - id: fastqc_read_2_original_report_zip_array
    type: File[]
    outputSource: subworkflow/fastqc_read_2_original_report_zip
  - id: fastqc_read_2_original_report_html_array
    type: File[]
    outputSource: subworkflow/fastqc_read_2_original_report_html
  - id: fastqc_read_2_original_stdout_array
    type: File[]
    outputSource: subworkflow/fastqc_read_2_original_stdout
  - id: fastqc_read_2_original_stderr_array
    type: File[]
    outputSource: subworkflow/fastqc_read_2_original_stderr

  - id: cutadapt_fastq_array
    type: File[]
    outputSource:
      - subworkflow/cutadapt_fastq_read_1
      - subworkflow/cutadapt_fastq_read_2
    linkMerge: merge_flattened
  - id: cutadapt_stdout_array
    type: File[]
    outputSource: subworkflow/cutadapt_stdout
  - id: cutadapt_stderr_array
    type: File[]
    outputSource: subworkflow/cutadapt_stderr

  - id: fastqc_read_1_cutadapted_report_zip_array
    type: File[]
    outputSource: subworkflow/fastqc_read_1_cutadapted_report_zip
  - id: fastqc_read_1_cutadapted_report_html_array
    type: File[]
    outputSource: subworkflow/fastqc_read_1_cutadapted_report_html
  - id: fastqc_read_1_cutadapted_stdout_array
    type: File[]
    outputSource: subworkflow/fastqc_read_1_cutadapted_stdout
  - id: fastqc_read_1_cutadapted_stderr_array
    type: File[]
    outputSource: subworkflow/fastqc_read_1_cutadapted_stderr

  - id: fastqc_read_2_cutadapted_report_zip_array
    type: File[]
    outputSource: subworkflow/fastqc_read_2_cutadapted_report_zip
  - id: fastqc_read_2_cutadapted_report_html_array
    type: File[]
    outputSource: subworkflow/fastqc_read_2_cutadapted_report_html
  - id: fastqc_read_2_cutadapted_stdout_array
    type: File[]
    outputSource: subworkflow/fastqc_read_2_cutadapted_stdout
  - id: fastqc_read_2_cutadapted_stderr_array
    type: File[]
    outputSource: subworkflow/fastqc_read_2_cutadapted_stderr

  - id: multiqc_report_data
    type: Directory
    outputSource: multiqc/report_data
  - id: multiqc_report_html
    type: File
    outputSource: multiqc/report_html
  - id: multiqc_stdout
    type: File
    outputSource: multiqc/stdout
  - id: multiqc_stderr
    type: File
    outputSource: multiqc/stderr

steps:

  - id: subworkflow

    scatter: input_fastq_pair

    in:
      - id: input_fastq_pair
        source: input_fastq_pairs_array

    out:
      - id: fastqc_read_1_original_report_zip
      - id: fastqc_read_1_original_report_html
      - id: fastqc_read_1_original_stdout
      - id: fastqc_read_1_original_stderr
      - id: fastqc_read_2_original_report_zip
      - id: fastqc_read_2_original_report_html
      - id: fastqc_read_2_original_stdout
      - id: fastqc_read_2_original_stderr
      - id: cutadapt_fastq_read_1
      - id: cutadapt_fastq_read_2
      - id: cutadapt_stdout
      - id: cutadapt_stderr
      - id: fastqc_read_1_cutadapted_report_zip
      - id: fastqc_read_1_cutadapted_report_html
      - id: fastqc_read_1_cutadapted_stdout
      - id: fastqc_read_1_cutadapted_stderr
      - id: fastqc_read_2_cutadapted_report_zip
      - id: fastqc_read_2_cutadapted_report_html
      - id: fastqc_read_2_cutadapted_stdout
      - id: fastqc_read_2_cutadapted_stderr

    run:

      class: Workflow

      inputs:
        - id: input_fastq_pair
          type: types/fastq_pair.yml#fastq_pair

      outputs:

        - id: fastqc_read_1_original_report_zip
          type: File
          outputSource: fastqc_read_1_original/report_zip
        - id: fastqc_read_1_original_report_html
          type: File
          outputSource: fastqc_read_1_original/report_html
        - id: fastqc_read_1_original_stdout
          type: File
          outputSource: fastqc_read_1_original/stdout
        - id: fastqc_read_1_original_stderr
          type: File
          outputSource: fastqc_read_1_original/stderr

        - id: fastqc_read_2_original_report_zip
          type: File
          outputSource: fastqc_read_2_original/report_zip
        - id: fastqc_read_2_original_report_html
          type: File
          outputSource: fastqc_read_2_original/report_html
        - id: fastqc_read_2_original_stdout
          type: File
          outputSource: fastqc_read_2_original/stdout
        - id: fastqc_read_2_original_stderr
          type: File
          outputSource: fastqc_read_2_original/stderr

        - id: cutadapt_fastq_read_1
          type: File
          outputSource: cutadapt/output_fastq_read_1
        - id: cutadapt_fastq_read_2
          type: File
          outputSource: cutadapt/output_fastq_read_2
        - id: cutadapt_stdout
          type: File
          outputSource: cutadapt/stdout
        - id: cutadapt_stderr
          type: File
          outputSource: cutadapt/stderr

        - id: fastqc_read_1_cutadapted_report_zip
          type: File
          outputSource: fastqc_read_1_cutadapted/report_zip
        - id: fastqc_read_1_cutadapted_report_html
          type: File
          outputSource: fastqc_read_1_cutadapted/report_html
        - id: fastqc_read_1_cutadapted_stdout
          type: File
          outputSource: fastqc_read_1_cutadapted/stdout
        - id: fastqc_read_1_cutadapted_stderr
          type: File
          outputSource: fastqc_read_1_cutadapted/stderr

        - id: fastqc_read_2_cutadapted_report_zip
          type: File
          outputSource: fastqc_read_2_cutadapted/report_zip
        - id: fastqc_read_2_cutadapted_report_html
          type: File
          outputSource: fastqc_read_2_cutadapted/report_html
        - id: fastqc_read_2_cutadapted_stdout
          type: File
          outputSource: fastqc_read_2_cutadapted/stdout
        - id: fastqc_read_2_cutadapted_stderr
          type: File
          outputSource: fastqc_read_2_cutadapted/stderr

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

        - id: fastqc_read_1_original
          run: tools/fastqc/main.cwl
          in:
            - id: name
              valueFrom: "fastqc_read_1_original"
            - id: input_file
              source: get_input_fastq_pair/read_1
            - id: input_file_format
              valueFrom: "fastq"
          out:
            - id: report_zip
            - id: report_html
            - id: stdout
            - id: stderr

        - id: fastqc_read_2_original
          run: tools/fastqc/main.cwl
          in:
            - id: name
              valueFrom: "fastqc_read_2_original"
            - id: input_file
              source: get_input_fastq_pair/read_2
            - id: input_file_format
              valueFrom: "fastq"
          out:
            - id: report_zip
            - id: report_html
            - id: stdout
            - id: stderr

        - id: cutadapt
          run: tools/cutadapt/fastq_paired.cwl
          in:
            - id: sample_name
              source: get_input_fastq_pair/sample_name
            - id: input_fastq_read_1
              source: get_input_fastq_pair/read_1
            - id: input_fastq_read_2
              source: get_input_fastq_pair/read_2
            - id: overlap
              default: 3
            - id: minimum_length
              default: 20
            - id: quality_3cutoff
              default: 20
          out:
            - id: output_fastq_read_1
            - id: output_fastq_read_2
            - id: stdout
            - id: stderr

        - id: fastqc_read_1_cutadapted
          run: tools/fastqc/main.cwl
          in:
            - id: name
              valueFrom: "fastqc_read_1_cutadapted"
            - id: input_file
              source: cutadapt/output_fastq_read_1
            - id: input_file_format
              valueFrom: "fastq"
          out:
            - id: report_zip
            - id: report_html
            - id: stdout
            - id: stderr

        - id: fastqc_read_2_cutadapted
          run: tools/fastqc/main.cwl
          in:
            - id: name
              valueFrom: "fastqc_read_2_cutadapted"
            - id: input_file
              source: cutadapt/output_fastq_read_2
            - id: input_file_format
              valueFrom: "fastq"
          out:
            - id: report_zip
            - id: report_html
            - id: stdout
            - id: stderr

  - id: multiqc
    run: tools/multiqc/main.cwl
    in:
      - id: input_files
        source:
          - subworkflow/fastqc_read_1_original_report_zip
          - subworkflow/fastqc_read_1_original_stdout
          - subworkflow/fastqc_read_1_original_stderr
          - subworkflow/fastqc_read_2_original_report_zip
          - subworkflow/fastqc_read_2_original_stdout
          - subworkflow/fastqc_read_2_original_stderr
          - subworkflow/cutadapt_stdout
          - subworkflow/cutadapt_stderr
          - subworkflow/fastqc_read_1_cutadapted_report_zip
          - subworkflow/fastqc_read_1_cutadapted_stdout
          - subworkflow/fastqc_read_1_cutadapted_stderr
          - subworkflow/fastqc_read_2_cutadapted_report_zip
          - subworkflow/fastqc_read_2_cutadapted_stdout
          - subworkflow/fastqc_read_2_cutadapted_stderr
        linkMerge: merge_flattened
    out:
      - id: report_data
      - id: report_html
      - id: stdout
      - id: stderr


