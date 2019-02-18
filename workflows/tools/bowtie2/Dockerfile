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
ENV BOWTIE2_VERSION=2.3.4.3
ADD https://github.com/BenLangmead/bowtie2/releases/download/v${BOWTIE2_VERSION}/bowtie2-${BOWTIE2_VERSION}-linux-x86_64.zip /tmp/.
RUN cd /usr/local && \
    unzip /tmp/bowtie2-${BOWTIE2_VERSION}-linux-x86_64.zip && \
    rm -rf /tmp/bowtie2-${BOWTIE2_VERSION}-linux-x86_64.zip && \
    chmod ugo+x /usr/local/bowtie2-${BOWTIE2_VERSION}-linux-x86_64/bowtie2 && \
    ln -s /usr/local/bowtie2-${BOWTIE2_VERSION}-linux-x86_64/bowtie2 /usr/local/bin/bowtie2 && \
    chmod ugo+x /usr/local/bowtie2-${BOWTIE2_VERSION}-linux-x86_64/bowtie2-build && \
    ln -s /usr/local/bowtie2-${BOWTIE2_VERSION}-linux-x86_64/bowtie2-build /usr/local/bin/bowtie2-build

# set the default command
CMD [ /usr/local/bin/bowtie2 ]


