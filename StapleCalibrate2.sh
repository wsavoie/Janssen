#!/bin/bash

rad=15.0
settlingTime=30000



lammpsFile=DimerShake.lammps
#read second line from file and grep number from that line
#read # atoms line and return #

for lws in `seq 11 12`; do
		fname=$(printf 'w=28_l=%s' "${lws}")
		cp ~/Janssen/Dimers/${fname} ~/Janssen/${fname} 
		#nm=number of molecules
		nm=1200
		echo ${fname}
		ss=${settlingTime};
		~/LAMMPS/src/lmp_serial -var tSteps ${ss} -var R ${rad} -var nParts ${nm} -var file ${fname} < ${lammpsFile}
		rm -f ${fname}
done;



