#!/bin/bash
# Script de clonage du dépôt source courrielleur et compilation win64 (version de développement)
#


repver="cpcmel_tb60.9.0_win64"

cd /d/Cm2/Dev/

rm -Rf $repver

# hg clone /f/Cm2v8/SrcTBCm2/cmel_tb60.9.0 $repver
mkdir $repver

cp -R /f/Cm2v8/SrcTBCm2/cmel_tb60.9.0/* $repver/.


cd /d/Cm2/Dev/$repver/comm-esr60/

cp /i/mozconfig/mozconfig-$repver mozconfig


ladate=`date +%Y%m%d`
mach --log-file "../../../logs/build_"$repver"_"$ladate".log" build
