#!/bin/sh
echo "Enter sequence: "
read sequence
python check_trajectory.py --seq ${sequence} --gro npt.gro
./grompp.sh
python writeBemeta.py --gro npt.gro
./check.sh
