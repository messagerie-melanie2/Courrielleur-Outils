#!/bin/bash
#
# Integre les modules courrielleur dans une compilation tb
#
# Prend en parametre un fichier de configuration
#
#
# Format du fichier de configuration:
# -----------------------------------
# fichier au format texte
# Paramètres:
#   chemintb="chemin de l'installateur ou package thunderbird"
#   listemodules=( "module1-version" "module2-version" ...)
#   chemincm2="repertoire de l'installateur courrielleur à produire"
#   libcm2="libelle de l'installateur courrielleur à produire"
#   tempdir="chemin du répertoire temporaire de travail"
#   sfx="chemin du fichier 7zSD.sfx"
#   apptag="chemin du fichier app.tag"
# 
# Commentaires:
# -------------
#   chemintb : exe à modifier (intégration des modules)
#     exemple: "/srv/partagesvm/Cm2v8/devcm2_tb60/devcm2_tb60.0_win64-20181005.exe"
#   listemodules : chemin des versions des modules à intégrer
#     exemple: ("/srv/projets/pacome/VersionsTest/pacome_devcm2_tb60/" "/srv/projets/courrielleur/VersionsTest/courrielleur_devcm2_tb60/")
#   chemincm2 : exemple "/srv/projets/cm2/"
#   libcm2 : exemple : "cm2-8.0.exe"
#   tempdir : exemple : "/tmp/cm2/"
#   sfx : exemple "/d/Cm2/Dev/essais/7zSD.sfx"
#   apptag : exemple "/d/Cm2/Dev/essais/app.tag"

# Notes:
# ------
# 7z
# windows mozilla-build v3.2 : 7-Zip 18.05 (x64) : Copyright (c) 1999-2018 Igor Pavlov : 2018-04-30
# => extraction omni.ja OK
# 7-Zip [64] 15.14 : Copyright (c) 1999-2015 Igor Pavlov : 2015-12-31
# => extraction omni.ja OK
# 
# debian jessie:7-Zip [64] 9.20  Copyright (c) 1999-2010 Igor Pavlov  2010-11-18
# => echec extraction omni.ja (thunderbird windows)
# cp omni.ja omni.zip
# unzip omni.zip
# # => extraction omni.zip windows OK


omnirep="omnirep"
packagetb="CourrielleurMel"
packagecm2="packagecm2"

omnicm2="archive.zip"

repcm2linux="CourrielleurMel"



function InsereModule(){

  module=$1
  
  if [ ! -d $module ]; then
    abandon "Erreur de module : '$module'"
  fi
  
  echo ""
  echo "==============================="
  echo "Insertion du module depuis: '$module'"
  
  # repertoire chrome
  echo "Traitement du repertoire chrome"
  rep=$module"/chrome"
  lrep=${#rep}
  # echo "longueur $lrep"
  for f in `find $rep -type f`;do
    # echo $f;
    fichier=`basename $f`   
    if [ "$fichier" != "${fichier/.manifest/}" ]; then
      echo "    ajout du contenu de $fichier"
      echo "" >> $tempdir"/"$omnirep"/chrome/chrome.manifest"
      cat $f >> $tempdir"/"$omnirep"/chrome/chrome.manifest"
      if [ $? != 0 ]; then
        abandon "Echec - code:$?"
      fi
    else
      dest=$tempdir"/"$omnirep"/chrome"${f:lrep}
      dir=`dirname $dest`
      #echo "dir $dir"
      mkdir -p $dir
      if [ $? != 0 ]; then
        abandon "Echec"
      fi
      echo "    copie du fichier '${f:lrep}' vers '$dest'"
      cp $f $dest
      if [ $? != 0 ]; then
        abandon "Echec"
      fi
    fi        
  done
  
  # repertoire modules
  rep=$module"/modules"
  if [ -d $rep ]; then
    echo "Traitement du repertoire modules"
    lrep=${#rep}
    # echo "longueur $lrep"
    for f in `find $rep -type f`;do
      dest=$tempdir"/"$omnirep"/modules"${f:lrep}
      dir=`dirname $dest`
      #echo "dir $dir"
      mkdir -p $dir
      if [ $? != 0 ]; then
        abandon "Echec - code:$?"
      fi
      echo "    copie du fichier '${f:lrep}' vers '$dest'"
      cp $f $dest
      if [ $? != 0 ]; then
        abandon "Echec"
      fi
    done
  fi
  
  # repertoire components
  rep=$module"/components"
  if [ -d $rep ]; then
    echo "Traitement du repertoire components"  
    lrep=${#rep}
    # echo "longueur $lrep"
    for f in `find $rep -type f`;do
      # echo $f;
      fichier=`basename $f`
      if [ "$fichier" != "${fichier/.manifest/}" ]; then
        echo "    ajout du contenu de $fichier"
        echo "" >> $tempdir"/"$omnirep"/components/components.manifest"
        cat $f >> $tempdir"/"$omnirep"/components/components.manifest"
        if [ $? != 0 ]; then
          abandon "Echec - code:$?"
        fi
      else
        dest=$tempdir"/"$omnirep"/components"${f:lrep}
        dir=`dirname $dest`
        #echo "dir $dir"
        mkdir -p $dir
        if [ $? != 0 ]; then
          abandon "Echec"
        fi
        echo "    copie du fichier '${f:lrep}' vers '$dest'"
        cp $f $dest
        if [ $? != 0 ]; then
          abandon "Echec - code:$?"
        fi
        if [ "$fichier" != "${fichier/.xpt/}" ]; then
          echo "interfaces $fichier" >> $tempdir"/"$omnirep"/components/components.manifest"
        fi
      fi        
    done
  fi
  
  # repertoire defaults
  rep=$module"/defaults"
  if [ -d $rep ]; then
    echo "Traitement du repertoire defaults"  
    lrep=${#rep}
    # echo "longueur $lrep"
    for f in `find $rep -type f`;do
      dest=$tempdir"/"$omnirep"/defaults"${f:lrep}
      dir=`dirname $dest`
      #echo "dir $dir"
      mkdir -p $dir
      if [ $? != 0 ]; then
        abandon "Echec - code:$?"
      fi
      echo "    copie du fichier '${f:lrep}' vers '$dest'"
      cp $f $dest
      if [ $? != 0 ]; then
        abandon "Echec"
      fi
    done
  fi
  
  # repertoire calendar-js (pour agenda)
  rep=$module"/calendar-js"
  if [ -d $rep ]; then
    echo "Traitement du repertoire calendar-js"  
    lrep=${#rep}
    # echo "longueur $lrep"
    for f in `find $rep -type f`;do
      dest=$tempdir"/"$omnirep"/calendar-js"${f:lrep}
      dir=`dirname $dest`
      #echo "dir $dir"
      mkdir -p $dir
      if [ $? != 0 ]; then
        abandon "Echec"
      fi
      echo "    copie du fichier '${f:lrep}' vers '$dest'"
      cp $f $dest
      if [ $? != 0 ]; then
        abandon "Echec"
      fi
    done
  fi
  
  # repertoire timezones (pour agenda)
  rep=$module"/timezones"
  if [ -d $rep ]; then
    echo "Traitement du repertoire timezones"  
    lrep=${#rep}
    # echo "longueur $lrep"
    for f in `find $rep -type f`;do
      dest=$tempdir"/"$omnirep"/timezones"${f:lrep}
      dir=`dirname $dest`
      #echo "dir $dir"
      mkdir -p $dir
      if [ $? != 0 ]; then
        abandon "Echec"
      fi
      echo "    copie du fichier '${f:lrep}' vers '$dest'"
      cp $f $dest
      if [ $? != 0 ]; then
        abandon "Echec"
      fi
    done
  fi
}



function abandon(){

  echo "$1. Arret des operations.";
  exit 1;
}


#vérification paramètres
if [ -z $1 ]; then
  abandon "Spécifier en paramètre le chemin du fichier de configuration"
fi

config=$1

if [ ! -f $config ]; then
  abandon "Fichier de configuration inexistant"
fi
echo "Fichier de configuration:$config"


#
# verifications du fichier de configuration
#
source $config

#   chemintb : exe à modifier (intégration des modules)
if [ -z $chemintb ]; then
  abandon "Chemin de l'installateur absent"
fi
if [ ! -f $chemintb ]; then
  abandon "Chemin de l'installateur inexistant ou non conforme"
fi

#   listemodules : chemin des versions des modules à intégrer
if [ -z $listemodules ]; then
  abandon "Liste des modules inexistante ou non conforme"
fi

nbmodules=${#listemodules[@]} 
if [ 0 -eq $nbmodules ]; then
  abandon "Aucun module specifie"
fi


#   chemincm2 : exemple "/srv/projets/cm2/"
if [ -z $chemincm2 ]; then
  abandon "Chemin de l'installateur courrielleur a produire non specifie"
fi

if [ ! -d $chemincm2 ]; then
  abandon "Chemin de l'installateur courrielleur a produire non conforme"
fi

#   libcm2 : exemple : "cm2-8.0.exe"
if [ -z $libcm2 ]; then
  abandon "Libelle de l'installateur courrielleur a produire non specifie"
fi



#   tempdir : exemple : "/tmp/cm2/"
if [ -z $tempdir ]; then
  abandon "Repertore temporaire non specifie"
fi

if [ ! -d $tempdir ]; then
  abandon "Repertore temporaire inexistant ou non conforme"
fi



#
# extraction de l'installateur thunderbird
#
echo ""
echo "======================================="
echo "Extraction de l'installateur thunderbird"

rm -Rf "$tempdir/*"

cd $tempdir
if [ ! -d "$packagetb" ]; then
  mkdir "$packagetb"
fi

rm -Rf "$packagetb/*"
if [ $? != 0 ]; then
  abandon "Echec vidage $packagetb - code:$?"
fi

tar -xvf "$chemintb"
if [ $? != 0 ]; then
  abandon "Echec extraction installateur thunderbird - code:$?"
fi

# extraction omni.ja
echo ""
echo "======================================="
echo "Extraction de omni.ja"

cp $packagetb/omni.ja .
if [ ! -d $omnirep ]; then
  mkdir $omnirep
fi

rm -Rf $omnirep/*
if [ $? != 0 ]; then
  abandon "Echec vidage $omnirep - code:$?"
fi
unzip -d $omnirep omni.ja 
if [ $? -eq 0 ]; then
 abandon "Echec extraction omni.ja - code:$?"
fi


#
# Retrait extension lightning
#
if [ $lightning -eq 0 ]; then
  echo "Retrait extension lightning"
  rm $packagetb"/distribution/extensions/{e2fda1a4-762b-4020-b5ad-a41df1933103}.xpi"
fi


#
# Insertion des modules
#
echo ""
echo "======================================="
echo "Nombre de modules a integrer:$nbmodules"

i=0
while [ $i -lt $nbmodules ]; do
  # echo item: $i
  module=${listemodules[$i]}
  # echo "Module:$module"
  
  InsereModule $module
  
  let i=i+1
done


#
# Ajout du fichier configuration.cfg spécifique minint dans $omnicm2
#
echo ""
echo "========================="
echo "Copie de "$courrielleurcfg"/configuration.cfg sous "$chemindist
cp $courrielleurcfg $chemindist
cp $courrielleurcfg $packagetb"/core/"


#
# Ajout des extensions supplémentaires
#
echo "Ajout des extensions supplémentaires sur le plat"
echo "--- Ajout SendLater3 ---"
cp $extensionssources"sendlater3@kamens.us.xpi" $extensionsfolder
cp $extensionssources"sendlater3@kamens.us.xpi" $packagetb"/core/distribution/extensions/"

echo "--- Ajout Quicktext ---"
cp $extensionssources"{8845E3B3-E8FB-40E2-95E9-EC40294818C4}.xpi" $extensionsfolder
cp $extensionssources"{8845E3B3-E8FB-40E2-95E9-EC40294818C4}.xpi" $packagetb"/core/distribution/extensions/"

echo "--- Ajout MultiLdap2 ---"
cp $extensionssources"multildap2@cyrille.coppitters.xpi" $extensionsfolder
cp $extensionssources"multildap2@cyrille.coppitters.xpi" $packagetb"/core/distribution/extensions/"

echo "--- Ajout changeQuote ---"
cp $extensionssources"{f6090211-2004-44d8-9090-be3c2adfd66f}.xpi" $extensionsfolder
cp $extensionssources"{f6090211-2004-44d8-9090-be3c2adfd66f}.xpi" $packagetb"/core/distribution/extensions/"


#
# Reconstruction du package
#
echo ""
echo "========================="
rm $omnicm2
cd $omnirep
echo "Reconstruction de omni.ja"
# 7z.exe a -tzip -mx0 ../$omnicm2 .
zip -r ../$omnicm2 * -0
if [ $? != 0 ]; then
  abandon "Echec reconstruction de omni.ja - code:$?"
fi

cd ..
cp $omnicm2 $packagetb/omni.ja
if [ $? != 0 ]; then
  abandon "Echec recopie omni.ja - code:$?"
fi


echo "Reconstruction du package"


if [ "$repcm2linux" != "$packagetb" ];then
  rm -Rf "$repcm2linux"
  mv "$packagetb" "$repcm2linux"
fi

rm -f "$chemincm2$libcm2"
rm -f "$chemincm2$libcm2.bz2"

tar -c --owner=0 --group=0 --numeric-owner --mode=go-w --exclude=.mkdir.done -f "$chemincm2$libcm2" "$repcm2linux"
if [ $? != 0 ]; then
  abandon "Echec reconstruction du package (tar) - code:$?"
fi

bzip2 "$chemincm2$libcm2"
if [ $? != 0 ]; then
  abandon "Echec reconstruction du package (bzip2) - code:$?"
fi

echo "Reconstruction du package terminée"
