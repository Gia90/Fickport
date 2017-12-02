#!/bin/bash

echo " _ ____ -| FRITZ-IMAGE |- ____ _"
echo
if [ ! -f devpwd.txt ]; then
    echo "[!] File \"devpwd.txt\" not found!"
    echo "[!] Please create this file and write your Speedport2 login device password in it!"
    exit 1
fi

IMAGENAME="fickport.tar"
SECRET=$(cat devpwd.txt)

echo "[>] Copying the required files ..."
mkdir -p var/fickport/
# Copy image main entrypoint script (install)
cp install var/
# Copy bin/*, daily-runner and fickport.sh
cp -R bin var/fickport
cp daily-runner.sh var/fickport/
cp ../fickport.sh var/fickport/

echo "[>] Set the value defined in \"devpwd.txt\" as login device password ..."
# Replace device password with the one defined in the "devpwd.txt" file
sed -i "s/\?\{8\}/$SECRET/" var/fickport/fickport.sh

echo "[>] Generating the image ..."
tar -cf "$IMAGENAME" var/
echo "[OK] fritzbox fake update-image created: $IMAGENAME"

echo "[>] Cleaning up and exiting"
rm -R var
