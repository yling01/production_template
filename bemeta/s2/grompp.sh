#!/bin/sh
echo "Hot Loop:"
read System
echo "How many replicas do you have:"
read numReplica
sed -i s/REPLICANUMBER/${numReplica}/ submit.job
numNodes=$(($numReplica * 5))
sed -i s/NODENUMBER/${numNodes}/ submit.job
sed -i s/SYSTEMNAME/${System}1/ submit.job
for i in `seq 0 $(($numReplica - 1))`
    do    
        gmx_mpi grompp -v -f mdrun.mdp -p cx_rsff2_tip3p.top -c npt.gro -o start${i}.tpr &> grompp${i}.log
done 
