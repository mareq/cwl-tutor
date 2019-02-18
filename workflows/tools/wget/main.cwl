class: CommandLineTool

cwlVersion: v1.0

id: wget
label: wget

baseCommand:
  - wget
arguments:
  - prefix: --directory-prefix
    valueFrom: "./downloads"
  - prefix: --timestamping
  - valueFrom: $(inputs.url)

requirements:
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerImageId: mareq/wget:jessie_1.0.0
    dockerFile:
      $include: Dockerfile
  - class: InitialWorkDirRequirement
    listing:
      - class: Directory
        basename: downloads
        listing: [ ]

inputs:
  - id: name
    type: string
    default: "wget"
  - id: url
    type: string

outputs:
  - id: downloaded_files
    type: File[]
    outputBinding:
      glob: ./downloads/*
  - id: stdout
    type: stdout
  - id: stderr
    type: stderr

stdout: $(inputs.name + ".out")
stderr: $(inputs.name + ".err")


