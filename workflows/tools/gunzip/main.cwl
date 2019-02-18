class: CommandLineTool

cwlVersion: v1.0

id: gunzip
label: gunzip

baseCommand:
  - gunzip
arguments:
  - prefix: --keep
  - valueFrom: $(inputs.gzipped_file.nameroot)

requirements:
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerImageId: debian:jessie
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.gzipped_file)
        writable: true

inputs:
  - id: name
    type: string
    default: "gunzip"
  - id: gzipped_file
    type: File

outputs:
  - id: gunzipped_file
    type: File
    outputBinding:
      glob: $(inputs.gzipped_file.nameroot)
  - id: stdout
    type: stdout
  - id: stderr
    type: stderr

stdout: $(inputs.name + "_" + inputs.gzipped_file.nameroot + ".out")
stderr: $(inputs.name + "_" + inputs.gzipped_file.nameroot + ".err")


