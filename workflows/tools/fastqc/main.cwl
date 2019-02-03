class: CommandLineTool

cwlVersion: v1.0

id: fastqc
label: fastqc

baseCommand:
  - fastqc
arguments:
  - prefix: --outdir
    valueFrom: .
  - prefix: --format
    valueFrom: $(inputs.input_files_format)
  - valueFrom: $(inputs.input_files)

requirements:
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerImageId: mareq/fastqc:0.11.8_1.0.0
    dockerFile:
      $include: Dockerfile

inputs:
  - id: input_files
    type: File[]
  - id: input_files_format
    type: string

outputs:
  - id: report_zip
    type: File[]
    outputBinding:
      glob: "*.zip"
  - id: report_html
    type: File[]
    outputBinding:
      glob: "*.html"
  - id: stdout
    type: stdout
  - id: stderr
    type: stderr

stdout: fastqc.out
stderr: fastqc.err


