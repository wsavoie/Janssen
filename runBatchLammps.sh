#!/bin/bash

radArr=(3.0 3.5 4.0 4.5 5.0 5.5 6.0 6.5 7.0 7.5 8.0 8.5 9.0 9.5 10.0);
aArr=(1.0 2.0 3.0 4.0 5.0);
for rads in `seq 0 14`; do
	for as in `seq 0 4`; do
		lmp_serial -var a ${aArr[$as]} -var cylInRad ${radArr[$rads]} < in.janssen
		done;
done;