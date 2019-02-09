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
    dockerImageId: mareq/multiqc:1.7_1.0.0
    dockerFile:
      $include: Dockerfile

inputs:
  - id: name
    type: string
    default: "multiqc"
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

stdout: $(inputs.name + ".out")
stderr: $(inputs.name + ".err")


