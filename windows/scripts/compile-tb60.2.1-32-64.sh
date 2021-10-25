#!/bin/bash
# Script de clonage du dépôt source courrielleur et compilations win32 et win64 (versions de développement)
#

repver32="devcm2_tb60.2.1_win32"

repver64="devcm2_tb60.2.1_win64"


cd /d/Cm2/Dev/

rm -Rf $repver64

rm -Rf $repver32


hg clone /f/Cm2v8/SrcTBCm2/cm2_tb60.2.1 $repver64

hg clone /f/Cm2v8/SrcTBCm2/cm2_tb60.2.1 $repver32


cp mozconfig-$repver64 $repver64/comm-esr60/mozconfig

cp mozconfig-$repver32 $repver32/comm-esr60/mozconfig



cd /d/Cm2/Dev/$repver64/comm-esr60/

ladate=`date +%Y%m%d`
mach --log-file "../../../logs/build_"$repver64"_"$ladate".log" build



cd /d/Cm2/Dev/$repver32/comm-esr60/

ladate=`date +%Y%m%d`
mach --log-file "../../../logs/build_"$repver32"_"$ladate".log" build

