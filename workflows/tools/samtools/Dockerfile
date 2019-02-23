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
      build-essential \
      libncurses5-dev \
      zlib1g-dev \
      libbz2-dev \
      liblzma-dev

# install fastqc 
ENV SAMTOOLS_VERSION=1.9
ADD https://github.com/samtools/samtools/releases/download/${SAMTOOLS_VERSION}/samtools-${SAMTOOLS_VERSION}.tar.bz2 /tmp/.
RUN cd /usr/local/src && \
    tar -xjf /tmp/samtools-${SAMTOOLS_VERSION}.tar.bz2 && \
    rm -rf /tmp/samtools-${SAMTOOLS_VERSION}.tar.bz2 && \
    cd /usr/local/src/samtools-${SAMTOOLS_VERSION} && \
    ./configure --prefix=/usr/local && \
    make && \
    make install

# set the default command
CMD [ /usr/local/bin/samtools ]


