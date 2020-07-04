#!/bin/sh
echo "How many replicas do you have:"
read numReplica
for i in `seq 0 $(($numReplica - 1))`
    do
        gmx_mpi convert-tpr -s start${i}.tpr -o start${i}.tpr -extend 50000 &> convert-tpr${i}.log
done
rm \#*
