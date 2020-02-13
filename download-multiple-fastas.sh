#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o xtrace

###############################################################################

# kamoser
# Feb 2020

# ABOUT

# INPUT: list of genbank ids (one per line)
# OUTPUT: nucleotide fasta files for each genbank id number

# run as ./script <list> (see below)

###############################################################################

list=$1

while IFS=$'\n' read -r id; do
  id+=($id); 
done < ${list}

for acn in "${id[@]}"; do 

  curl "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nucleotide&amp;id=${acn}&amp;rettype=fasta" \
  > ${acn}.fasta

  #NCBI API rate limit is 3 requests per second w/out a key
  sleep 0.2s

done

###############################################################################

echo "Read through script. Good job you."

###############################################################################
