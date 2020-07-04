#!/bin/sh
dir=s2
cp ../../initial-structure-generator/*/${dir}*.pdb .
./pdb2gmx.sh
