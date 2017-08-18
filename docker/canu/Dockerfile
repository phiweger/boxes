FROM ubuntu:16.04

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y build-essential perl libboost-all-dev git-all

RUN cd /usr/local/src && \
    git clone https://github.com/marbl/canu.git && \
    cd canu/src && \
    make -j 8
RUN ln -s /usr/local/src/canu/Linux-amd64/bin/canu /usr/local/bin/canu

ENTRYPOINT ["canu"]


# docker build -t canu .

# trouble shoot:
# change entrypoint to /bin/bash
# docker run -it canu

# remove all docker containers
# docker rm $(docker ps -a -q)
