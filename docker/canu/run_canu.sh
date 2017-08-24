#! /bin/bash

# how to pass command line options
# https://stackoverflow.com/questions/21533564/how-to-send-files-as-arguments-of-docker-commands

canu -d $canu_out -p $canu_name -nanopore-raw $canu_in

# https://github.com/sjackman/docker-bio/blob/master/bwa/Dockerfile