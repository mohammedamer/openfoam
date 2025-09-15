FROM ubuntu:24.04

RUN apt update
RUN apt install -y wget software-properties-common

RUN sh -c "wget -O - https://dl.openfoam.org/gpg.key > /etc/apt/trusted.gpg.d/openfoam.asc"
RUN add-apt-repository http://dl.openfoam.org/ubuntu

RUN apt update

RUN apt -y install openfoam11

RUN cat /opt/openfoam11/etc/bashrc >> /root/.bashrc

WORKDIR /experiments