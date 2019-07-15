#!/usr/bin/env python3

"""
File: interaction_energies_psi4.py
Author: Tom Mason
Email: tommason14@gmail.com
Github: https:github.com/tommason14
Description: Uses the output of chem_assist -r (which writes to energies.csv).
Note splits path on first directory of `Path`. Make sure these are different
for each different system!
"""


import pandas as pd
from dfply import *

@make_symbolic
def if_else(bools, val_if_true, val_if_false):
    return np.where(bools, val_if_true, val_if_false)

df = pd.read_csv('energies.csv')

print(
    (df >>
    mutate(Config = X.Path.str.split('/').str[0]) >>
    mutate(Type = if_else(X.Path.str.contains('frag'), 'frag', 'complex')) >>
    mutate(SRS = X['HF/DFT'] + 1.64 * X.MP2_opp) >>
    group_by(X.Config) >>
    spread(X.Type, X.SRS) >>
    group_by(X.Config) >>
    mutate(sum_frags = X.frag.sum()) >>
    arrange(X.Path) >>
    head(1) >>
    mutate(e_int = X.complex - X.sum_frags) >>
    filter_by(X.sum_frags != 0.0) >>
    mutate(e_int_kj = X.e_int * 2625.5) >>
    select(X.Config, X.e_int_kj)).to_string(index=False, justify='left')
)
