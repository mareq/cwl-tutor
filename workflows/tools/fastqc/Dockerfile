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
      perl \
      unzip \
      openjdk-7-jre

# install fastqc 
ENV FASTQC_VERSION=0.11.8
ADD http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v${FASTQC_VERSION}.zip /tmp/
RUN cd /usr/local && \
    unzip /tmp/fastqc_v${FASTQC_VERSION}.zip && \
    rm -rf /tmp/fastqc_v${FASTQC_VERSION}.zip && \
    chmod ugo+x /usr/local/FastQC/fastqc && \
    ln -s /usr/local/FastQC/fastqc /usr/local/bin/fastqc

# set the default command
CMD [ /usr/local/bin/fastqc ]


