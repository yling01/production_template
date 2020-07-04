#!/bin/sh
gmx_mpi grompp -v -f ion.mdp -c solvate.gro -p cx_rsff2_tip3p.top -o ion.tpr &> grompp.log
