#!/bin/bash

IMAGENAME="fickport.tar"

mkdir -p var/fickport/
cp install var/
cp *.sh var/fickport/
cp -R bin var/fickport

tar -cf "$IMAGENAME" var/
rm -R var

echo "[OK] fritzbox fake update-image created: $IMAGENAME"
