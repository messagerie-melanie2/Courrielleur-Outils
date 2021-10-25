#!/bin/sh
#
# construction du depôt et compilation de la version devcm2_tb60.2.1_linux64
#

repmozconfig="/media/sf_cm2outilsconfigs/mozconfig/"

repver="devcmel_tb60.9.0"

cd /home/pm/Cm2/Dev

rm -Rf $repver

hg clone /media/sf_projets/Cm2v8/SrcTBCm2/cmel_tb60.9.0 $repver

cp $repmozconfig"mozconfig-"$repver"_linux64" $repver"/comm-esr60/mozconfig"

cd $repver"/comm-esr60"

ladate=`date +%Y%m%d`
./mach --log-file "../../../logs/build_"$repver"_linux64_"$ladate".log" build

