#!/bin/sh

for f in $(squeue -u $USER | grep $USER | awk '{print $1}')
do 
cd $(scontrol show jobid $f | grep WorkDir | awk -F '=' '{print $2}')
pwd
[[ -f opt-freq.log ]] && (cat opt-freq.log | plotgauss) || (
grep -iq 'FMO' opt.log && (cat opt.log | plotfmo) || (
cat opt.log | plotmp2) 
)
done
