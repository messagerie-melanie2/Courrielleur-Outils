#!/bin/bash
# Script de clonage du dépôt source courrielleur et compilation win64
#
repver="cmel-8.5.1_win64"

cd /d/Cm2/Prod/
rm -Rf $repver
cp -R /y/gmcd/courrielleur_sources/cmel_tb60.9.1 $repver
cd /d/Cm2/Prod/$repver/comm-esr60/
cp /w/mozconfig/mozconfig-$repver mozconfig

ladate=`date +%Y%m%d`
mach --log-file "../../../logs/build_"$repver"_"$ladate".log" build
