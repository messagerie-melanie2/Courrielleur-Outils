#!/bin/bash
# Script de clonage du dépôt source courrielleur MCE et compilation win64 (versions de développement)
#
repver64="mi-tb60.9.1_win32"

cd /d/Cm2/Prod/
rm -Rf $repver64
hg clone /y/MCE/Sources/mi_tb60.9.1 $repver64
cp mozconfig-$repver64 $repver64/comm-esr60/mozconfig
cd /d/Cm2/Prod/$repver64/comm-esr60/

ladate=`date +%Y%m%d`
mach --log-file "../../../logs/build_"$repver64"_"$ladate".log" build
