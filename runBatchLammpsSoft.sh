#!/bin/bash

# radArr=(3.0 3.5 4.0 4.5 5.0 5.5 6.0 6.5 7.0 7.5 8.0 8.5 9.0 9.5 10.0);
radArr=(7.0 8.0 9.0 10.0 6.0 6.0 6.0 6.0 6.0);
# tStepsArr=(12.0 13.0 14.0 15.0 16.0); #slope for linear curve relating particle amount and pourSteps
# fillP=(0.2 0.4 0.6 0.8);
# fillP=(0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 .5 .6 .7 .8 0.2 0.3 0.4 0.5 0.6 0.7 0.85);
#  fillP=(442 885 1327 1770 2212 2655 3097 3540 3982 4425 4867 5310 5752 6195 6637 7080 7522);
# fillP=(221 443 664 885 1106 1328 1549 1770 1991 2213 2434 2655 2876 3098 3319 3540 3761);
fillP=(1770 3540 5310 7080 8850 10620 12390 14160 15930 17700 19470 21240 23010 24780 26550 28320 30090);
#fillP=(0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8);
# for rads in `seq 0 14`; do

#./runBatchLammpsMol.sh 10000 8 soft
framePerPart=${1};
fname="${2}";
cp ~/Janssen/Dimers/${fname} ~/Janssen/${fname}
lammpsFile=janssenDimer.lammps
#read second line from file and grep number from that line
#read # atoms line and return #
atomNum=$(sed -n '2p' < $fname|grep -o [0-9]*);
for rads in `seq 3 3`; do
	for n in `seq 0 16`; do #0-7
		h=100;
		phi=0.26;
		r=${radArr[$rads]}
		#np=number of particles
		#nm=number of molecules
		np=${fillP[$n]};
		nm=$(python -c "print(int(round(${fillP[$n]}/${atomNum})))"); 
		# np=$(python -c "print(int(6*${phi}*${radArr[$rads]}*${radArr[$rads]}*${h}*${fillP[$n]}))");
		echo $np
		ss=$(python -c "print(int(${framePerPart}*${np}/(${r}*${r}*6-12*${r}+6)+50000))"); 
		echo $ss
		if [ "$HOSTNAME" == "phys42232.physics.gatech.edu" ]
		then
			~/LAMMPS/src/lmp_serial -var tSteps ${ss} -var R ${radArr[$rads]} -var nParts ${nm} -var file ${fname} < ${lammpsFile}
		else
			lmp_serial -var tSteps ${ss} -var R ${radArr[$rads]} -var nParts ${nm} < ${lammpsFile}
		fi
		done;
done;
rm -f ${fname}