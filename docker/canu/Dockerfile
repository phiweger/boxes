FROM ubuntu:16.04

# USER root

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y build-essential perl libboost-all-dev git-all default-jre

RUN cd /usr/local/src && \
    git clone https://github.com/marbl/canu.git && \
    cd canu/src && \
    make -j 8
RUN ln -s /usr/local/src/canu/Linux-amd64/bin/canu /usr/local/bin/canu

# ENTRYPOINT ["canu"]
# http://angus.readthedocs.io/en/2016/week3/CTB_docker.html

# docker build -t canu .

# trouble shoot:
# change entrypoint to /bin/bash
# docker run -it canu

# override entrypoint to debug
# docker run -i -t -v $(pwd):/tmp -w /tmp --entrypoint=/bin/bash canu
# mkdir foo  # permission denied
# https://stackoverflow.com/questions/24288616/permission-denied-on-accessing-host-directory-in-docker


# remove all docker containers
# docker rm $(docker ps -a -q)


# docker run -v $(pwd):/tmp -w /tmp canu -d run -p bug genomeSize=6m gnuplotTested=true -nanopore-raw reads.fq