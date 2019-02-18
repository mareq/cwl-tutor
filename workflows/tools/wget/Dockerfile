# base image: debian jessie (stable)
FROM debian:jessie

# update the base system
RUN apt-get update && \
    apt-get --fix-missing --yes upgrade && \
    apt-get --fix-missing --yes install \
      software-properties-common

# install wget
RUN apt-get update && \
    apt-get --fix-missing --yes install \
      wget


# set the default command
CMD [ /usr/bin/wget ]


