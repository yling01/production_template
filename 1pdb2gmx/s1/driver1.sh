#!/bin/sh
dir=s1
cp ../../initial-structure-generator/*/${dir}*.pdb .
./pdb2gmx.sh
