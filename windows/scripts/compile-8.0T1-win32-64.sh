#!/bin/bash
# Script de clonage du dépôt source courrielleur et compilations win32 et win64
#


repver32="8.0T1_win32"

repver64="8.0T1_win64"


cd /d/Cm2/Prod/


rm -Rf $repver64

rm -Rf $repver32


hg clone /f/Cm2v8/SrcTBCm2/cm2_tb60.2.1 $repver64
if [ $? != 0 ]; then
  echo "Echec clone (win64)"
  exit 1
fi

hg clone /f/Cm2v8/SrcTBCm2/cm2_tb60.2.1 $repver32
if [ $? != 0 ]; then
  echo "Echec clone (win32)"
  exit 1
fi


cp mozconfig-$repver64 $repver64/comm-esr60/mozconfig
if [ $? != 0 ]; then
  echo "Echec cp mozconfig-$repver64"
  exit 1
fi

cp mozconfig-$repver32 $repver32/comm-esr60/mozconfig
if [ $? != 0 ]; then
  echo "Echec cp mozconfig-$repver32"
  exit 1
fi



cd /d/Cm2/Prod/$repver64/comm-esr60/

ladate=`date +%Y%m%d`
mach --log-file "../../../logs/build_"$repver64"_"$ladate".log" build



cd /d/Cm2/Prod/$repver32/comm-esr60/

ladate=`date +%Y%m%d`
mach --log-file "../../../logs/build_"$repver32"_"$ladate".log" build

