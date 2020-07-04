#!/bin/sh
./grompp.sh
python writeBemeta.py
./check.sh
