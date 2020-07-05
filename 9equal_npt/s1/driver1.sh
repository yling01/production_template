#!/bin/sh
echo "Enter sequence: "
read sequence
python check_trajectory.py --seq ${sequence} --gro nvt.gro
./grompp.sh

