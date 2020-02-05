#!/usr/bin/env sh

replace_comma_with_ampersand(){
sed 's/,/ \& /g'
}

add_newline(){
sed 's/$/ \\\\/'
}

data="$1"
header=$(head -1 "$data")


echo "\\begin{longtable}{|c|c|}"
echo "\hline"
echo "Frequencies (cm$^{-1}$) & Intensities \\"
echo "\hline"
echo "\endfirsthead"
echo "\hline"
echo "Frequencies (cm$^{-1}$) & Intensities \\" 
echo "\hline"
echo "\endhead"
echo "\hline \multicolumn{2}{r}{\textit{Continued on next page}} \\"
echo "\endfoot"
printf "  %s\n" $(tail -n +2 "$data") | replace_comma_with_ampersand | add_newline
echo "\caption{}"
echo "\label{fig:"$data"}"
echo "\end{table}"
