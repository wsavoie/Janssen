#!/bin/bash
cd ~/Janssen
rad=15.0
settlingTime=30000



lammpsFile=DimerShake2.lammps
#read second line from file and grep number from that line
#read # atoms line and return #
o=0.5
for lws in `seq 24 24`; do
		fname=$(printf 'w=28_l=%s_o=%s' "${lws}" "${o}")
		cp ~/Janssen/Dimers/${fname} ~/Janssen/${fname} 
		#nm=number of molecules
		nm=2
		echo ${fname}
		ss=${settlingTime};
		~/LAMMPS/src/lmp_serial -var tSteps ${ss} -var R ${rad} -var nParts ${nm} -var file ${fname} < ${lammpsFile}
		#mpirun -np 4 ~/LAMMPS/src/lmp_gpu -var tSteps ${ss} -var R ${rad} -var nParts ${nm} -var file ${fname} < ${lammpsFile}
		rm -f ${fname}
done;



