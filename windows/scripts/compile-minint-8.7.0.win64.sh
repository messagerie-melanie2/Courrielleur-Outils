#!/bin/bash
# Script de clonage du dépôt source courrielleur et compilation win64
#
repver="minint-8.7.0_win64"

cd /d/Cm2/Prod/
rm -Rf $repver
hg clone /y/gmcd/courrielleur_sources/minint_tb60.9.1 $repver
cd /d/Cm2/Prod/$repver/comm-esr60/
cp /w/mozconfig/mozconfig-$repver mozconfig

ladate=`date +%Y%m%d`
mach --log-file "../../../logs/build_"$repver"_"$ladate".log" build
