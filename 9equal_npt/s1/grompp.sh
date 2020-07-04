#!/bin/sh
gmx_mpi grompp -v -f npt.mdp -c nvt.gro -r nvt.gro -p cx_rsff2_tip3p.top -o npt.tpr &> grompp.log
