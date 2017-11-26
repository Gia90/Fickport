#!/bin/bash

speedport=speedport.ip


# Get the challenge value
challenge=$(wget -q -O - "http://${speedport}/data/Login.json?_time=1511719881983&_rand=666&csrf_token=sercomm_csrf_token" | sed 's/.*challenge", "varvalue"\: "\([^"]*\).*/\1/')

# Log in to the server.  This only needs to be done once.
wget --save-cookies cookies.txt \
     --keep-session-cookies \
     --post-data 'user=foo&password=bar' \
     --delete-after \
     http://server.com/auth.php
