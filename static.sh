#!/usr/bin/env bash

# get the scripts root directory
dir_root="$(cd "$(dirname "$0")"; pwd -P)"

dir_static="${dir_root}/static"

for static_group_name in $(ls ${dir_static}/.); do

  dir_workflows="${dir_static}/${static_group_name}/workflows"
  workflow_file="main.cwl"
  dir_jobs="${dir_static}/${static_group_name}/jobs"

  for job_name in $(ls ${dir_jobs}/.); do
    dir_job="${dir_jobs}/${job_name}"
    dir_job_output="${dir_job}/output"
    if [ -e "${dir_job_output}" ]; then
      echo "Skipping already finshed job: ${job_name}"
      continue
    fi
    echo "Running job: ${job_name}"
    mkdir "${dir_job_output}"
    cd "${dir_job_output}"
    #cwltool "${dir_workflows}/${workflow_file}" "${dir_job}/job.yml" > cwltool.out 2> cwltool.err
    #cwltool --tmp-outdir-prefix ${dir_job_output}/cwltool-tmp/ --leave-tmpdir "${dir_workflows}/${workflow_file}" "${dir_job}/job.yml" > cwltool.out 2> cwltool.err
    #cwltool --debug --tmp-outdir-prefix ${dir_job_output}/cwltool-tmp/ --leave-tmpdir "${dir_workflows}/${workflow_file}" "${dir_job}/job.yml" > cwltool.out 2> cwltool.err
    cwltool --cachedir ${dir_job_output}/cwltool-cache/ --leave-tmpdir "${dir_workflows}/${workflow_file}" "${dir_job}/job.yml" > cwltool.out 2> cwltool.err
    #cwltool --debug --cachedir ${dir_job_output}/cwltool-cache/ --leave-tmpdir "${dir_workflows}/${workflow_file}" "${dir_job}/job.yml" > cwltool.out 2> cwltool.err
  done
done


