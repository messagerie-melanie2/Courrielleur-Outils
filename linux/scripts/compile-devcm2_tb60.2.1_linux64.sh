#!/bin/sh
#
# construction du depôt et compilation de la version devcm2_tb60.2.1_linux64
#

repver="devcm2_tb60.2.1"

cd /home/pm/Cm2/Dev

rm -Rf $repver

hg clone /media/sf_Projets/Cm2v8/SrcTBCm2/cm2_tb60.2.1 $repver

cp "mozconfig-"$repver"_linux64" $repver"/comm-esr60/mozconfig"

cd $repver"/comm-esr60"

ladate=`date +%Y%m%d`
./mach --log-file "../../../logs/build_"$repver"_linux64_"$ladate".log" build

