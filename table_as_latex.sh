#!/usr/bin/env sh

replace_comma_with_ampersand(){
sed 's/,/ \& /g'
}

add_newline(){
sed 's/$/ \\\\/'
}

data="$1"
header=$(head -1 "$data")

echo "\\begin{table}[h]"
echo "  \\begin{tabular}{|cc|}"
echo "  \hline" 
echo "  $header" | replace_comma_with_ampersand | add_newline
echo "  \hline"
printf "  %s\n" $(tail -n +2 "$data") | replace_comma_with_ampersand | add_newline
echo "  \hline"
echo " \end{tabular}"
echo "\caption{}"
echo "\label{fig:"$data"}"
echo "\end{table}"
