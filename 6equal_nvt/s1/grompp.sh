#!/bin/sh
gmx_mpi grompp -v -f nvt.mdp -c em2.gro -r em2.gro -p cx_rsff2_tip3p.top -o nvt.tpr &> grompp.log
