#!/bin/sh

# Grep data from all log.lammps* files.
# Sort by Step (the first value of the dump command
# Print to first argument, or data.csv otherwise.


# data- assumes Step is the first value of dump
ls log.lammps* | 
  xargs sed -n '/Step/,/Loop/{/Step/!{/Loop/!p}}' |
  sort -nk 1 |
  grep '^\s\+[0-9]\+\s\+-*[0-9]\+' |
  sed 's/^\s\+//;s/\s\+$//;s/\s\+/,/g' > data.tmp

# find the header from first output
ls log.lammps* |
  head -1 |
  xargs grep Step |
  sed 's/^\s\+//;s/\s\+$//;s/\s\+/,/g' > header.tmp

cat header.tmp data.tmp > ${1:-data.csv}

rm header.tmp data.tmp
