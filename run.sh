#!/usr/bin/env bash

# get the scripts root directory
dir_root="$(cd "$(dirname "$0")"; pwd -P)"

dir_workflows="${dir_root}/workflows"
dir_jobs="${dir_root}/jobs"

for workflow_file in $(find ${dir_workflows} -maxdepth 1 -type f -name "*.cwl" -printf '%f\n'); do
  workflow_name=${workflow_file%.cwl}
  for job_name in $(ls ${dir_jobs}/.); do
    dir_job="${dir_jobs}/${job_name}"
    dir_job_output="${dir_job}/output_${workflow_name}"
    if [ -e "${dir_job_output}" ]; then
      echo "Skipping already finshed job: ${workflow_name}@${job_name}"
      continue
    fi
    echo "Running job: ${workflow_name}@${job_name}"
    mkdir "${dir_job_output}"
    cd "${dir_job_output}"
    #cwltool "${dir_workflows}/${workflow_file}" "${dir_job}/job.yml" > cwltool.out 2> cwltool.err
    #cwltool --tmp-outdir-prefix ${dir_job_output}/cwltool-tmp/ --leave-tmpdir "${dir_workflows}/${workflow_file}" "${dir_job}/job.yml" > cwltool.out 2> cwltool.err
    #cwltool --debug --tmp-outdir-prefix ${dir_job_output}/cwltool-tmp/ --leave-tmpdir "${dir_workflows}/${workflow_file}" "${dir_job}/job.yml" > cwltool.out 2> cwltool.err
    cwltool --cachedir ${dir_job_output}/cwltool-cache/ --leave-tmpdir "${dir_workflows}/${workflow_file}" "${dir_job}/job.yml" > cwltool.out 2> cwltool.err
    #cwltool --debug --cachedir ${dir_job_output}/cwltool-cache/ --leave-tmpdir "${dir_workflows}/${workflow_file}" "${dir_job}/job.yml" > cwltool.out 2> cwltool.err
  done
done


