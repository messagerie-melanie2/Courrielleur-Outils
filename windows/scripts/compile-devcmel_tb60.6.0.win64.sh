#!/bin/bash
# Script de clonage du dépôt source courrielleur et compilation win64 (version de développement)
#


repver="devcmel_tb60.6.0_win64"

cd /d/Cm2/Dev/

rm -Rf $repver

hg clone /f/Cm2v8/SrcTBCm2/cmel_tb60.6.0 $repver

cp mozconfig-$repver $repver/comm-esr60/mozconfig

cd /d/Cm2/Dev/$repver/comm-esr60/

ladate=`date +%Y%m%d`
mach --log-file "../../../logs/build_"$repver"_"$ladate".log" build
