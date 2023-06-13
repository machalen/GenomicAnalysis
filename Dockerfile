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
 bzip2 g++ tabix

#Set the working directory to install samtools
WORKDIR /bin

#Download Samtools from GitHub
RUN wget https://github.com/samtools/samtools/releases/download/1.17/samtools-1.17.tar.bz2

##################################################################################
#Unbzip and untar package
RUN tar --bzip2 -xf samtools-1.17.tar.bz2
WORKDIR /bin/samtools-1.17
RUN ./configure
RUN make
RUN make install
RUN rm /bin/samtools-1.17.tar.bz2

###################################################################################
#Download bcftools
WORKDIR /bin
RUN wget https://github.com/samtools/bcftools/releases/download/1.17/bcftools-1.17.tar.bz2
RUN tar --bzip2 -xf bcftools-1.17.tar.bz2
WORKDIR /bin/bcftools-1.17
RUN ./configure
RUN make
RUN make install
RUN rm /bin/bcftools-1.17.tar.bz2

###################################################################################
#Download plink
WORKDIR /bin
RUN mkdir plinkDir
WORKDIR /bin/plinkDir
RUN wget https://s3.amazonaws.com/plink1-assets/plink_linux_x86_64_20230116.zip
#unzip the program
RUN unzip plink_linux_x86_64_20230116.zip
RUN rm plink_linux_x86_64_20230116.zip

###################################################################################
#Download Impute5
WORKDIR /bin
RUN wget https://www.dropbox.com/sh/mwnceyhir8yze2j/AAD2VrkZze6ZLrcGX-jok4KRa/impute5_v1.1.5.zip
RUN unzip impute5_v1.1.5.zip
RUN rm impute5_v1.1.5.zip

###################################################################################
#Add the downloaded programs to the path variable
ENV PATH $PATH:/bin/plinkDir
ENV PATH $PATH:/bin/samtools-1.17
ENV PATH $PATH:/bin/bcftools-1.17
ENV PATH $PATH:/bin/impute5_v1.1.5

WORKDIR /
