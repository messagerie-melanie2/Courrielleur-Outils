#!/bin/bash
# Script de clonage du dépôt source courrielleur MCE et compilation win64 (versions de développement)
#
repver="dgfip-tb60.9.1_win64"

cd /d/Cm2/Prod/
rm -Rf $repver
cp -Rrv /y/MCE/Sources/dgfip_tb60.9.1 $repver
cp /w/mozconfig/mozconfig-$repver $repver/comm-esr60/mozconfig
cd /d/Cm2/Prod/$repver/comm-esr60/
rm -Rf /d/Cm2/Prod/$repver/.hg

ladate=`date +%Y%m%d`
mach --log-file "../../../logs/build_"$repver"_"$ladate".log" build
