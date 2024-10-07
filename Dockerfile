FROM neurodebian:buster-non-free

RUN apt-get update && \
    apt-get install -y gnupg curl wget

# add nuerodebian-buster, and its gpg key (needed for fsl)
RUN wget -O- http://neuro.debian.net/lists/buster.us-nh.full | tee /etc/apt/sources.list.d/neurodebian.sources.list && \
    apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xA5D32F012649A5A9 && \
    apt-get update

RUN apt-get install -y fsl-core

ENV FSLDIR=/usr/share/fsl/5.0
ENV PATH=$FSLDIR/bin:$PATH
ENV FSLOUTPUTTYPE=NIFTI_GZ
ENV LD_LIBRARY_PATH=/usr/lib/fsl/5.0:$LD_LIBRARY_PATH

RUN mkdir -p /data/input /data/output

WORKDIR /data

ENTRYPOINT ["/bin/bash"]
