# base image: debian jessie (stable)
FROM debian:jessie

# update the base system
RUN apt-get update && \
    apt-get --fix-missing --yes upgrade && \
    apt-get --fix-missing --yes install \
      software-properties-common

# install dependencies
RUN apt-get update && \
    apt-get --fix-missing --yes install \
      python3-pip

# install multiqc 
ENV CUTADAPTS_VERSION=1.18
RUN pip3 install --upgrade setuptools && \
    pip3 install cutadapt==${CUTADAPTS_VERSION}

# set the default command
CMD [ /usr/local/bin/cutadapt ]


