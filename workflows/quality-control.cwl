#!/usr/bin/env cwl-runner
class: Workflow

cwlVersion: v1.0

requirements:
  - class: StepInputExpressionRequirement

inputs:
  - id: input_fastq_files
    type: File[]

outputs:
  - id: fastqc_report_zip
    type: File[]
    outputSource: fastqc/report_zip
  - id: fastqc_report_html
    type: File[]
    outputSource: fastqc/report_html
  - id: fastqc_stdout
    type: File
    outputSource: fastqc/stdout
  - id: fastqc_stderr
    type: File
    outputSource: fastqc/stderr
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
  - id: fastqc
    run: tools/fastqc/main.cwl
    in:
      - id: input_files
        source: input_fastq_files
      - id: input_files_format
        default: fastq
    out: [ report_zip, report_html, stdout, stderr ]

  - id: multiqc
    run: tools/multiqc/main.cwl
    in:
      - id: input_files
        source: fastqc/report_zip
    out: [ report_data, report_html, stdout, stderr ]


