#!/bin/sh
echo "How many replicas do you have:"
read numReplica
for i in `seq 0 $(($numReplica - 1))`
    do
        gmx_mpi dump -s start${i}.tpr &> ${i}.txt
done
grep "fudge" *txt
