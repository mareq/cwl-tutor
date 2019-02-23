class: CommandLineTool

cwlVersion: v1.0

id: sam2bam
label: sam2bam

baseCommand:
  - samtools
arguments:
  - valueFrom: view
  - valueFrom: -b
  - valueFrom: $(inputs.input_sam.path)
  - valueFrom: -o
  - valueFrom: $(inputs.input_sam.nameroot + ".bam")

requirements:
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerImageId: mareq/samtools:1.9_1.0.0
    dockerFile:
      $include: Dockerfile

inputs:
  - id: name
    type: string
    default: "sam2bam"
  - id: input_sam
    type: File

outputs:
  - id: output_bam
    type: File
    outputBinding:
      glob: $(inputs.input_sam.nameroot + ".bam")
  - id: stdout
    type: stdout
  - id: stderr
    type: stderr

stdout: $(inputs.name + "_" + inputs.input_sam.nameroot + ".out")
stderr: $(inputs.name +  "_" + inputs.input_sam.nameroot + ".err")


