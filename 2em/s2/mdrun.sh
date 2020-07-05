#!/bin/sh
gmx_mpi mdrun -v -s em.tpr -deffnm em &>mdrun.log
echo "Enter the sequence: "
read sequence
python check_trajectory.py --seq ${sequence} --gro em.gro
