class: CommandLineTool

cwlVersion: v1.0

id: multiqc
label: multiqc


baseCommand:
  - multiqc
arguments:
  - valueFrom: $(inputs.input_files)

requirements:
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerImageId: mareq/multiqc:latest_1.0.0
    dockerFile:
      $include: Dockerfile

inputs:
  - id: input_files
    type: File[]

outputs:
  - id: report_data
    type: Directory
    outputBinding:
      glob: multiqc_data
  - id: report_html
    type: File
    outputBinding:
      glob: multiqc_report.html
  - id: stdout
    type: stdout
  - id: stderr
    type: stderr

stdout: multiqc.out
stderr: multiqc.err


