#!/bin/sh

# TODO: add header info/help

speedport="speedport.ip"
# The device password to login to the Speedport2
devpwd="????????"

# Get the challenge value
challenge=$(wget -q -O - "http://${speedport}/data/Login.json?_time=1511719881983&_rand=666&csrf_token=sercomm_csrf_token" | sed 's/.*challenge", "varvalue"\: "\([^"]*\).*/\1/')

echo "[>] CHALLENGE: $challenge"

# Hashed password + challenge
hashpwd=$(echo -n "${devpwd}${challenge}" | sha256sum | cut -d" " -f1)

echo "[>] HASHEDPWD: $hashpwd"

# Log in to the server
echo "[>] LOG IN ..."
wget -q \
     --save-cookies cookies.txt \
     --keep-session-cookies \
     --post-data "password=${hashpwd}&showpw=0&csrf_token=sercomm_csrf_token" \
     --delete-after \
     "http://${speedport}/data/Login.json?lang=en"

# TODO: check if correctly logged in

# Extract CSRF Token
csrftoken=$(wget --load-cookies cookies.txt -q -O - "http://${speedport}/html/content/overview/index.html?lang=en" | grep "var csrf_token " | cut -d "'" -f 2)

echo "[>] CSRF-TOKEN: $csrftoken"

# Reboot!
echo "[>] REBOOT!"
wget -q \
     --load-cookies cookies.txt \
     --post-data "reboot_device=true&csrf_token=${csrftoken}" \
     --delete-after \
     "http://${speedport}/data/Reboot.json?_time=1511727315027&_rand=128&csrf_token=${csrftoken}&lang=en"

# Cleaning up
rm cookies.txt
