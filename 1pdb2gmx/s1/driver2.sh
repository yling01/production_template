#!/bin/sh
echo "Number of residues:"
read NRES
sed s/NRESREPLACE/${NRES}/ VMD_GenMissingImpropersForCPs_template.sh &> VMD_GenMissingImpropersForCPs.sh
vmd -e VMD_GenMissingImpropersForCPs.sh
python Py_AddMissingImpropersForCPs.py cx_amber99sbMod_tip3p_temp.top &> cx_amber99sbMod_tip3p.top
./mover.sh
