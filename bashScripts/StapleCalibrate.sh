#!/bin/bash
cd ~/Janssen
rad=15.0
settlingTime=25000

#make sure to add name of folder when running script!
#./StapleCalibrate.sh v3


lammpsFile=DimerShake2.lammps
#read second line from file and grep number from that line
#read # atoms line and return #
o=0.5
# fillP=(2500 2000 1400 1200 1000 1000 1000);
# lw=(0 6 12 18 24 30 36);

fillP=(2300 1700 1300 850 700 600 500);
lw=(0 6 12 18 24 30 36);
#append this to folder name 
app="$1"; 
for lws in `seq 0 6`; do
		fname=$(printf 'w=28_l=%s_o=%s' "${lw[$lws]}" "${o}")
		cp ~/Janssen/Dimers/${fname} ~/Janssen/${fname} 
		#nm=number of molecules
		nm=${fillP[$lws]}
		echo ${fname}
		ss=${settlingTime};
		randz=$RANDOM;
		~/LAMMPS/src/lmp_serial -var tSteps ${ss} -var R ${rad} -var nParts ${nm} -var file ${fname} -var app ${app} -var randz ${randz}< ${lammpsFile}
		#mpirun -np 4 ~/LAMMPS/src/lmp_gpu -var tSteps ${ss} -var R ${rad} -var nParts ${nm} -var file ${fname} < ${lammpsFile}
		rm -f ${fname}
done;



