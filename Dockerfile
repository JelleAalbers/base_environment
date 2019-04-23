FROM opensciencegrid/osgvo-el7

RUN yum -y upgrade

RUN yum -y install \
            cmake \
            davix-devel \
            dcap-devel \
            doxygen \
            dpm-devel \
            glib2-devel \
            globus-gass-copy-devel \
            gtest-devel \
            json-c-devel \
            lfc-devel \
            libattr-devel \
            libssh2-devel \
            libuuid-devel \
            openldap-devel \
            srm-ifce-devel \
            xrootd-client-devel \
            zlib-devel

ADD create-env /tmp/

RUN cd /tmp && \
    bash create-env /opt/XENONnT && \
    rm -f create-env

# relax permissions so we can build cvmfs tar balls
RUN chmod 1777 /cvmfs

# build info
RUN echo "Timestamp:" `date --utc` | tee /image-build-info.txt

# also make the image usable for interactive use
RUN groupadd xenon && \
    useradd -m -s /bin/bash -g xenon xenon
USER xenon:xenon
WORKDIR /home/xenon


