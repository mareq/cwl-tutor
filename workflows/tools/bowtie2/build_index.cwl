class: CommandLineTool

cwlVersion: v1.0

id: bowtie2-build
label: bowtie2-build

baseCommand:
  - bowtie2-build
arguments:
  - prefix: -f
  - valueFrom: $(inputs.reference_genome)
  - valueFrom: $(inputs.index_base)

requirements:
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerImageId: mareq/bowtie2:2.3.4.3_1.0.0
    dockerFile:
      $include: Dockerfile

inputs:
  - id: name
    type: string
    default: "bowtie2-build"
  - id: reference_genome
    type: File
  - id: index_base
    type: string

outputs:
  - id: index
    type: File[]
    outputBinding:
      glob: $(inputs.index_base + "*")
  - id: stdout
    type: stdout
  - id: stderr
    type: stderr

stdout: $(inputs.name + ".out")
stderr: $(inputs.name + ".err")




