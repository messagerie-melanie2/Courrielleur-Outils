#!/bin/bash
# Script de clonage du dépôt source courrielleur MCE et compilation win32 (versions de développement)
#
repver="dgfip-tb60.9.1_win32"

cd /d/Cm2/Prod/
rm -Rf $repver
cp -Rrv /y/MCE/Sources/dgfip_tb60.9.1 $repver
cp /w/mozconfig/mozconfig-$repver $repver/comm-esr60/mozconfig
cd /d/Cm2/Prod/$repver/comm-esr60/

ladate=`date +%Y%m%d`
mach --log-file "../../../logs/build_"$repver"_"$ladate".log" build
