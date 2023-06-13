#########################################################
#Genomic tools
#Dockerfile with useful tools for pre-processing genomic data
#########################################################
#Build the image based on Ubuntu
FROM ubuntu:mantic

#Maintainer and author
MAINTAINER Magdalena Arnal <magdalena.arnalsegura@iit.it>

#Install required libraries in ubuntu
RUN apt-get update && apt-get install --yes build-essential gcc-multilib apt-utils zlib1g-dev\
 libbz2-dev git perl gzip ncurses-dev libncurses5-dev libbz2-dev make unzip\
 liblzma-dev libssl-dev libcurl4-openssl-dev libgdbm-dev libnss3-dev libreadline-dev libffi-dev wget\
 bzip2 g++ tabix plink

#Set the working directory to install samtools
WORKDIR /bin

#Download Samtools from GitHub
RUN wget https://github.com/samtools/samtools/releases/download/1.17/samtools-1.17.tar.bz2

#Unbzip and untar package
RUN tar --bzip2 -xf samtools-1.17.tar.bz2
WORKDIR /bin/samtools-1.17
RUN ./configure
RUN make
RUN make install
RUN rm /bin/samtools-1.17.tar.bz2

#Add samtools to the path variable
ENV PATH $PATH:/bin/samtools-1.17

WORKDIR /
