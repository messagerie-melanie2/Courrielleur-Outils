#!/bin/bash
# Script de clonage du dépôt source courrielleur et compilation win64
#
repver="cmel-8.7.0T5_win64"

cd /C/Projets/Courrielleur-Compilation/
rm -Rf $repver
hg clone /C/Projets/Courrielleur-Sources/cmel_tb60.9.1 $repver
cd /C/Projets/Courrielleur-Compilation/$repver/comm-esr60/
cp /C/Projets/Courrielleur-Outils/windows/mozconfig/mozconfig-$repver mozconfig

ladate=`date +%Y%m%d`
mach --log-file "./Logs/build_"$repver"_"$ladate".log" build
