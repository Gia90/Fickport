#!/bin/bash

mkdir var
cp install var/
tar -cf fickport.tar var/
rm -R var

echo "[OK] fritzbox update-image created: fickport.tar"
