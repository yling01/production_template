#!/bin/sh
gmx_mpi solvate -cp box.gro -cs spc216.gro -p cx_rsff2_tip3p.top -o solvate.gro &>solvate.log
