# Fickport
## Introduction

## How to use
### Manually reboot

### Auto daily reboot

# Technical details
Wanna know more about techy stuff behind this project?    
Read further!
## Speedport Entry 2
The **Speedport Entry 2** is a shitty router bla bla bla
### Login process
Javascript code similar to the one used to generate the hashed password for the login POST call:
````
function hash(devpwd, challenge){
 var hash_pwd = devpwd+challenge;
 var password = sjcl.codec.hex.fromBits(sjcl.hash.sha256.hash(hash_pwd));
 return password;
}
````
### Reboot

### More info
Read the content of [fickport.sh](fickport.sh) to know more about the command HTTP calls.

## Fickport
### Fickport script
[fickport.sh](fickport.sh)

### Daily Runner script
Run a command everyday at a specific time, without "crontab", "at" or even GNU coreutils "date" cli tools.
[daily-runner.sh](fritz-image/daily-runner.sh)

This script is used to run "fickport" on the Fritz MIPS device daily to reboot the shitty speedport every night.

## Binaries
MIPS little endian binaries
