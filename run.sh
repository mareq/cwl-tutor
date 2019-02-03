#!/usr/bin/env bash

# get the scripts root directory
dir_root="$(cd "$(dirname "$0")"; pwd -P)"

dir_workflows="${dir_root}/workflows"
dir_jobs="${dir_root}/jobs"

for job_name in $(ls ${dir_jobs}/.); do
  echo "Running job: ${job_name}"
  dir_job="${dir_jobs}/${job_name}"
  dir_job_output="${dir_job}/output"
  mkdir "${dir_job_output}"
  cd "${dir_job_output}"
  cwltool "${dir_workflows}/quality-control.cwl" "${dir_job}/job.yml"
  #cwltool --leave-tmpdir "${dir_workflows}/quality-control.cwl" "${dir_job}/job.yml"
  #cwltool --debug "${dir_workflows}/quality-control.cwl" "${dir_job}/job.yml"
done


