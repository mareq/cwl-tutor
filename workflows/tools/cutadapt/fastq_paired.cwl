class: CommandLineTool

cwlVersion: v1.0

id: cutadapt
label: cutadapt


baseCommand:
  - cutadapt
arguments:
  - prefix: --format
    valueFrom: "fastq"
  - prefix: --overlap
    valueFrom: $(inputs.overlap)
  - prefix: --minimum-length
    valueFrom: $(inputs.minimum_length)
  - prefix: --quality-cutoff
    valueFrom: $(inputs.quality_3cutoff)
  - prefix: --pair-filter
    valueFrom: "any"
  - prefix: --output
    valueFrom: >
      ${
        var nameparts = inputs.input_fastq_read_1.basename.match(/^([^.]*)(\..*)?/);
        var nameroot = nameparts[1];
        var nameext = nameparts[2];
        return nameroot + inputs.output_fastq_suffix + nameext;
      }
  - prefix: --paired-output
    valueFrom: >
      ${
        var nameparts = inputs.input_fastq_read_2.basename.match(/^([^.]*)(\..*)?/);
        var nameroot = nameparts[1];
        var nameext = nameparts[2];
        return nameroot + inputs.output_fastq_suffix + nameext;
      }
  - valueFrom: $(inputs.input_fastq_read_1)
  - valueFrom: $(inputs.input_fastq_read_2)

requirements:
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerImageId: mareq/cutadapt:latest_1.0.0
    dockerFile:
      $include: Dockerfile

inputs:
  - id: name
    type: string
    default: "cutadapt"
  - id: sample_name
    type: string
  - id: input_fastq_read_1
    type: File
  - id: input_fastq_read_2
    type: File
  - id: output_fastq_suffix
    type: string
    default: "_cutadapt"
  - id: overlap
    type: int
  - id: minimum_length
    type: int
  - id: quality_3cutoff
    type: int

outputs:
  - id: output_fastq_read_1
    type: File
    outputBinding:
      glob: >
        ${
          var nameparts = inputs.input_fastq_read_1.basename.match(/^([^.]*)(\..*)?/);
          var nameroot = nameparts[1];
          var nameext = nameparts[2];
          return nameroot + inputs.output_fastq_suffix + nameext;
        }
  - id: output_fastq_read_2
    type: File
    outputBinding:
      glob: >
        ${
          var nameparts = inputs.input_fastq_read_2.basename.match(/^([^.]*)(\..*)?/);
          var nameroot = nameparts[1];
          var nameext = nameparts[2];
          return nameroot + inputs.output_fastq_suffix + nameext;
        }
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
    return inputs.sample_name + suffix + ".out";
  }
stderr: >
  ${
    var suffix = inputs.name;
    if(suffix) {
      suffix = "_" + suffix;
    }
    return inputs.sample_name + suffix + ".err";
  }


