#!/bin/sh
gmx_mpi grompp -v -f em.mdp -c prot.gro -p cx_rsff2_tip3p.top -o em.tpr &>grompp.log

