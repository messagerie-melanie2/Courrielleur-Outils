#!/bin/bash
# Script de clonage du dépôt source courrielleur MCE et compilation win64 (versions de développement)
#


repver64="dgfip_tb60.9.1"


cd /d/Cm2/Dev/

rm -Rf $repver64


hg clone /y/MCE/Sources/dgfip_tb60.9.1 $repver64


cp mozconfig-$repver64 $repver64/comm-esr60/mozconfig


cd /d/Cm2/Dev/$repver64/comm-esr60/

ladate=`date +%Y%m%d`
mach --log-file "../../../logs/build_"$repver64"_"$ladate".log" build
