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
    valueFrom: $(inputs.input_file_format)
  - valueFrom: $(inputs.input_file)

requirements:
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerImageId: mareq/fastqc:0.11.8_1.0.0
    dockerFile:
      $include: Dockerfile

inputs:
  - id: name
    type: string
    default: "fastqc"
  - id: input_file
    type: File
  - id: input_file_format
    type: string

outputs:
  - id: report_zip
    type: File
    outputBinding:
      glob: "*_fastqc.zip"
  - id: report_html
    type: File
    outputBinding:
      glob: "*_fastqc.html"
  - id: stdout
    type: stdout
  - id: stderr
    type: stderr

stdout: >
  ${
    var suffix = inputs.name;
    if(suffix) {
      suffix = "_" + suffix;
    }

    var nameparts = inputs.input_file.basename.match(/^([^.]*)(\..*)?/);
    var nameroot = nameparts[1];
    return nameroot + suffix + ".out";
  }
stderr: >
  ${
    var suffix = inputs.name;
    if(suffix) {
      suffix = "_" + suffix;
    }

    var nameparts = inputs.input_file.basename.match(/^([^.]*)(\..*)?/);
    var nameroot = nameparts[1];
    return nameroot + suffix + ".err";
  }


