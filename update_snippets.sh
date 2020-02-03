#!/usr/bin/env bash

if [[ $USER =~ (tommason|tmas0023) ]]
then
  snipdir="$HOME/Documents/repos/vim-snippets"
else
  snipdir="$HOME/vim-snippets"
fi

cd "$snipdir"
git add .
git commit -m "Snippets updated"
git push 

vim -c ":PluginUpdate vim-snippets" -c ":q" -c ":q"