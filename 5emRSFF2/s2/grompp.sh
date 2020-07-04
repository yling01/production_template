#!/bin/sh
gmx_mpi grompp -f em2.mdp -c ion.gro -p cx_rsff2_tip3p.top -o em2.tpr &> grompp.log
