#!/bin/sh
gmx_mpi grompp -v -f nvt.mdp -c npt.gro -r npt.gro -p cx_rsff2_tip3p.top -o nvt.tpr &> grompp.log
