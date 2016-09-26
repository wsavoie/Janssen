#!/bin/bash

# radArr=(3.0 3.5 4.0 4.5 5.0 5.5 6.0 6.5 7.0 7.5 8.0 8.5 9.0 9.5 10.0);
radArr=(4.0 5.0 6.0 7.0 16.0 6.0 6.0 6.0 6.0 6.0 6.0);
# tStepsArr=(12.0 13.0 14.0 15.0 16.0); #slope for linear curve relating particle amount and pourSteps
# fillP=(0.2 0.4 0.6 0.8);
# fillP=(0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 .5 .6 .7 .8 0.2 0.3 0.4 0.5 0.6 0.7 0.85);
fillP=(0.05 0.1 0.2 0.3 0.5 0.7 0.8 0.875 .9 .8 0.2 0.3 0.4 0.5 0.6 0.7 0.85);
# for rads in `seq 0 14`; do
for rads in `seq 1 1`; do
	for n in `seq 0 7`; do
		h=75;
		phi=0.59;
		r=${radArr[$rads]}
		np=$(python -c "print(int(6*${phi}*${radArr[$rads]}*${radArr[$rads]}*${h}*${fillP[$n]}))");
		echo $np
		# ss=$(python -c "print(int(150*${np}))"); 
		# ss=$(python -c "print(int(3162*${np}/(((${radArr[$rads]}-2.0)*3)*(${radArr[$rads]}-2.0)*3)+30000))"); 
		ss=$(python -c "print(int(3162*${np}/(${r}*${r}*6-12*${r}+6)+50000))"); 
		echo $ss
		# lmp_serial -var a ${aArr[$step]} -var cylInRad ${radArr[$rads]} < in.janssen
		# lmp_serial -var tSteps ${ss} -var R ${radArr[$rads]} -var nParts ${np} < in.janssen
		lmp_serial -var tSteps ${ss} -var R ${radArr[$rads]} -var nParts ${np} < in.janssenCyl

		done;
done;