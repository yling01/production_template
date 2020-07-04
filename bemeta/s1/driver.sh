#!/bin/sh
./grompp.sh
python writeBemeta.py --grp npt.gro
./check.sh
