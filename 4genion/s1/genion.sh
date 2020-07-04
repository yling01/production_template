#!/bin/sh
gmx_mpi genion -s ion.tpr -p cx_rsff2_tip3p.top -o ion.gro -nname NA -neutral &> genion.log<< EOF
13
EOF
