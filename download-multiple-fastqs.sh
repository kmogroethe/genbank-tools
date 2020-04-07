#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o xtrace

###############################################################################

# kamoser
# April 2020

# ABOUT

# INPUT: list of SRA ids (one per line)
# OUTPUT: paired read fastq files

# run as ./script <list> (see below)

###############################################################################

module load sratoolkit

vdb-config --set /repository/user/default-path=/pine/scr/k/a/kamoser/ncbi
vdb-config --set /repository/user/main/public/root=/pine/scr/k/a/kamoser/ncbi/public

###############################################################################

list=$1

while IFS=$'\n' read -r id; do

  fastq-dump -I --split-files $id

  #NCBI API rate limit is 3 requests per second w/out a key
  #sleep 0.2s

done < $list

###############################################################################

echo "Read through script. Good job you."

###############################################################################
