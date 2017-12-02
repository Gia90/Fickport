#!/bin/bash

IMAGENAME="fickport.tar"
SECRET=$(cat devpwd.txt)

mkdir -p var/fickport/
cp install var/
cp *.sh var/fickport/
cp -R bin var/fickport

# Replace device password with the one defined in the "devpwd.txt" file
sed -i "s/\?\{8\}/$SECRET/" var/fickport/fickport.sh

tar -cf "$IMAGENAME" var/
rm -R var

echo "[OK] fritzbox fake update-image created: $IMAGENAME"
