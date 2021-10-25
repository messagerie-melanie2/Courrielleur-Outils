#!/bin/bash
# Script de clonage du dépôt source courrielleur et compilation win32
#


repver="cmel-8.5T3_win32"

cd /d/Cm2/Prod/

rm -Rf $repver

hg clone /f/Cm2v8/SrcTBCm2/cmel_tb60.9.1 $repver


cd /d/Cm2/Prod/$repver/comm-esr60/

cp /i/mozconfig/mozconfig-$repver mozconfig


ladate=`date +%Y%m%d`
mach --log-file "../../../logs/build_"$repver"_"$ladate".log" build
