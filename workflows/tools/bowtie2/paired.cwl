class: CommandLineTool

cwlVersion: v1.0

id: bowtie2
label: bowtie2

baseCommand:
  - bowtie2
arguments:
  - prefix: "-x"
    valueFrom: $(inputs.input_index_directory.path + "/" + inputs.input_index_filename_prefix)
  - prefix: "-1"
    valueFrom: $(inputs.input_fastq_read_1.path)
  - prefix: "-2"
    valueFrom: $(inputs.input_fastq_read_2.path)
  - prefix: "-S"
    valueFrom: $(inputs.sample_name + "_" + inputs.name + ".sam")

requirements:
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerImageId: mareq/bowtie2:2.3.4.3_1.0.0
    dockerFile:
      $include: Dockerfile

inputs:
  - id: name
    type: string
    default: "bowtie2"
  - id: sample_name
    type: string
  - id: input_index_directory
    type: Directory
  - id: input_index_filename_prefix
    type: string
  - id: input_fastq_read_1
    type: File
  - id: input_fastq_read_2
    type: File

outputs:
  - id: output_sam
    type: File
    outputBinding:
      glob: $(inputs.sample_name + "_" + inputs.name + ".sam")
  - id: stdout
    type: stdout
  - id: stderr
    type: stderr

stdout: $(inputs.name + "_" + inputs.sample_name + ".out")
stderr: $(inputs.name +  "_" + inputs.sample_name + ".err")


