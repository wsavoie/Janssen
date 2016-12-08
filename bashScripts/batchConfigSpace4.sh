#!/bin/bash
cd ~/Janssen
rad=20.0
settlingTime=30000



lammpsFile=janssenDimer.lammps
#read second line from file and grep number from that line
#read # atoms line and return #
o=0.5
for a1 in `seq 5 6`; do
for a2 in `seq 0 10`; do
		# a1=100_a2=100_l=28_w=28_d=0.5_o=0.5
		A1=$(($a1 * 20 - 100))
		A2=$(($a2 * 20 - 100))
		fname=$(printf 'a1=%s_a2=%s_l=28_w=28_d=0.5_o=0.5' "${A1}" "${A2}")
		cp ~/Janssen/Dimers/${fname} ~/Janssen/${fname} 
		cp ~/Janssen/${lammpsFile} ~/Janssen/${fname}
		#nm=number of molecules
		nm=1000
		echo ${fname}
		ss=${settlingTime};
		~/LAMMPS/src/lmp_serial -var tSteps ${ss} -var R ${rad} -var nParts ${nm} -var file ${fname} < ${lammpsFile}
		#mpirun -np 4 ~/LAMMPS/src/lmp_gpu -var tSteps ${ss} -var R ${rad} -var nParts ${nm} -var file ${fname} < ${lammpsFile}
		rm -f ${fname}
done;
done;


