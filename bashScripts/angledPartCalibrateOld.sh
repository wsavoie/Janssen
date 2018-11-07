#!/bin/bash
cd ~/Janssen
rad=20.0
settlingTime=25000



lammpsFile=janssenDimerShakev1.lammps
#read second line from file and grep number from that line
#read # atoms line and return #
o=0.5
app="v3"; 
lw=(28);

# for a1 in `seq 10 10`; do
# for a2 in `seq 10 10`; do
# 		A1=$(($a1 * 20 - 100))
# 		A2=$(($a2 * 20 - 100))
a1=(100 100 100 100 100 100 100 100 100 100 100)
a2=(-100 -80 -60 -40 -20 0 20 40 60 80 100)
for lws in `seq 0 5`; do
		A1=${a1[$lws]}
		A2=${a2[$lws]}
		fname=$(printf 'a1=%s_a2=%s_l=28_w=28_d=0.5_o=0.5' "${A1}" "${A2}")
		cp ~/Janssen/Dimers/${fname} ~/Janssen/${fname}
		#cp ~/Janssen/${lammpsFile} ~/Janssen/${fname} 
		#nm=number of molecules
		nm=1100
		echo ${fname}
		ss=${settlingTime};
		randz=$RANDOM;
		~/LAMMPS/src/lmp_serial -var tSteps ${ss} -var R ${rad} -var nParts ${nm} -var file ${fname} -var app ${app} -var randz ${randz}< ${lammpsFile}
		#mpirun -np 4 ~/LAMMPS/src/lmp_gpu -var tSteps ${ss} -var R ${rad} -var nParts ${nm} -var file ${fname} < ${lammpsFile}
		rm -f ${fname}
done;



