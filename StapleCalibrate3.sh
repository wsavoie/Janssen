#!/bin/bash

rad=15.0
settlingTime=30000



lammpsFile=DimerShake2.lammps
#read second line from file and grep number from that line
#read # atoms line and return #

for lws in `seq 13 15`; do
		fname=$(printf 'w=28_l=%s' "${lws}")
		cp ~/Janssen/Dimers/${fname} ~/Janssen/${fname} 
		#nm=number of molecules
		nm=900
		echo ${fname}
		ss=${settlingTime};
		~/LAMMPS/src/lmp_serial -var tSteps ${ss} -var R ${rad} -var nParts ${nm} -var file ${fname} < ${lammpsFile}
		rm -f ${fname}
done;



