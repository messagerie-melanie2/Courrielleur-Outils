#!/bin/bash
# Passe toutes les branche git à la valeur passée
branch="$1"

echo "Switching branch for Sources"
cd /srv/projets/gmcd/courrielleur_sources/cmel_tb60.9.1
git checkout $branch
git pull --all
git branch
echo "Commiting Mercurials..."
hg commit -m "Commited by script"
echo "----------------------------"

echo "Switching branch for Anais"
cd /srv/projets/anaismoz/courrielleur_anais
git checkout $branch
git pull --all
git branch
echo "----------------------------"

echo "Switching branch for Archibald"
cd /srv/projets/archibald/courrielleur_archibald
git checkout $branch
git pull --all
git branch
echo "----------------------------"

echo "Switching branch for Courrielleur"
cd /srv/projets/courrielleur/courrielleur_courrielleur
git checkout $branch
git pull --all
git branch
echo "----------------------------"

echo "Switching branch for Contacts"
cd /srv/projets/ContactsDAV/courrielleur_contacts
git checkout $branch
git pull --all
git branch
echo "----------------------------"

echo "Switching branch for Lightning"
cd /srv/projets/Lightning/courrielleur_lightning
git checkout $branch
git pull --all
git branch
echo "----------------------------"

echo "Switching branch for Pacome"
cd /srv/projets/pacome/courrielleur_pacome
git checkout $branch
git pull --all
git branch
echo "----------------------------"

echo "Switching branch for Commentaires"
cd /srv/projets/commentaires/courrielleur_commentaires
git checkout $branch
git pull --all
git branch
echo "----------------------------"

echo "Switching branch for Melanissimo"
cd /srv/projets/cm2m2ssimo/courrielleur_melanissimo
git checkout $branch
git pull --all
git branch
echo "----------------------------"

echo "Switching branch for Webapps"
cd /srv/projets/WebAppsM2/courrielleur_webapps
git checkout $branch
git pull --all
git branch
echo "----------------------------"

echo "Switching branch for Signature"
cd /srv/projets/signature/courrielleur_signature
git checkout $branch
git pull --all
git branch
echo "----------------------------"

echo "Switching branch for Mailredirect"
cd /srv/projets/mailredirect/courrielleur_mailredirect
git checkout $branch
git pull --all
git branch
echo "----------------------------"

echo "Switching branch for ManuallySortFolders"
cd /srv/projets/manually_sort_folders/courrielleur_manually_sort_folders
git checkout $branch
git pull --all
git branch
echo "----------------------------"

echo "Switching branch for Lookout"
cd /srv/projets/lookout/courrielleur_lookout
git checkout $branch
git pull --all
git branch
echo "----------------------------"

echo "Switching branch for ColorFolders"
cd /srv/projets/color_folders/courrielleur_color_folders
git checkout $branch
git pull --all
git branch
echo "----------------------------"

echo "Switching branch for Quicktext"
cd /srv/projets/quicktext/Courrielleur-Quicktext
git checkout $branch
git pull --all
git branch
echo "----------------------------"

echo "Switching branch for SendLater"
cd /srv/projets/send_later/Courrielleur-Send-Later
git checkout $branch
git pull --all
git branch
echo "----------------------------"
