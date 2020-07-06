#!/bin/sh
echo "Enter the sequence: "
read sequence
python check_trajectory.py --seq ${sequence} --gro nvt.gro
./grompp.sh

