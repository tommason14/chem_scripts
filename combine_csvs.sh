#!/usr/bin/env sh

# help="Pass in csv files that you would like to combine.\n"
# help+="i.e. combine_csvs file1 file2\n"
# help+="Note: Assumes that header lines include the word 'File'\n"
#
# if grep -eq "-h" "$@"
# then 
# echo $help
# exit 
# fi

cat $@ | sed '2,${/File/d;}' > tmp_file
header=$(head -n 1 tmp_file)
echo $header
cat tmp_file | tail -n +2 | sort -t ',' -k 1
rm tmp_file
