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
      python3-pip \
      libfreetype6-dev \
      pkg-config

# install multiqc 
RUN pip3 install multiqc

# set the default command
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
CMD [ /usr/local/bin/multiqc ]


