#!/bin/bash

speedport=speedport.ip
devpwd=***REMOVED***

# Get the challenge value
challenge=$(wget -q -O - "http://${speedport}/data/Login.json?_time=1511719881983&_rand=666&csrf_token=sercomm_csrf_token" | sed 's/.*challenge", "varvalue"\: "\([^"]*\).*/\1/')

# Hashed password + challenge
hashpwd=$(echo -n "${devpwd}${challenge}" | sha256sum)

# Log in to the server
wget --save-cookies cookies.txt \
     --keep-session-cookies \
     --post-data 'password=${hashpwd}&showpw=0&csrf_token=sercomm_csrf_token' \
     --delete-after \
     "http://${speedport}//data/Login.json?lang=en"


