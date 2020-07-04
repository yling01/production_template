#!/bin/sh
gmx_mpi editconf -f em.gro -o box.gro -bt dodecahedron -d 1.0 &>editconf.log

