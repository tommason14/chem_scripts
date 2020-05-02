#!/bin/sh

# Assumes a structure such as 
# .
# ├── struct1
# │   ├── opt.dat
# │   ├── opt.inp
# │   ├── opt.job
# │   ├── opt.log
# │   └── spec
# │       └── opt_equil.xyz
# ├── struct2
# │   ├── opt.dat
# │   ├── opt.inp
# │   ├── opt.job
# │   ├── opt.log
# │   └── spec
# │       └── opt_equil.xyz

newdir="equilibrated"
[ ! -d $newdir ] && mkdir $newdir

find_xyz(){
    struct="$1"
    xyz=$(find . -path "*$struct*spec*xyz")
    echo "$struct -> $xyz"
    cp "$xyz" "$newdir/$struct.xyz"
}

structs=$(find . -type d -depth 1 | awk -F'/' '{print $2}' | grep -v $newdir)
while read -r struct
do
find_xyz $struct
done <<< "$structs"
