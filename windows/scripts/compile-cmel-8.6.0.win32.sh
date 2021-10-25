#!/bin/bash
# Script de clonage du dépôt source courrielleur et compilation win64
#
repver="cmel-8.6.0_win32"

cd /d/Cm2/Prod/
rm -Rf $repver
hg clone /y/gmcd/courrielleur_sources/cmel_tb60.9.1 $repver
cd /d/Cm2/Prod/$repver/comm-esr60/
cp /w/mozconfig/mozconfig-$repver mozconfig

ladate=`date +%Y%m%d`
mach --log-file "../../../logs/build_"$repver"_"$ladate".log" build
