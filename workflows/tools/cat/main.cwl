class: CommandLineTool

cwlVersion: v1.0

id: cat
label: cat

baseCommand:
  - cat
arguments:
  - valueFrom: $(inputs.input_files)

requirements:
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerImageId: debian:jessie

inputs:
  - id: name
    type: string
    default: "cat"
  - id: input_files
    type: File[]
  - id: output_file_name
    type: string

outputs:
  - id: output_file
    type: stdout
  - id: stderr
    type: stderr

stdout: $(inputs.output_file_name)
stderr: $(inputs.name + "_" + inputs.output_file_name + ".err")


