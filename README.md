# WG-Reboot
## Introduction

## Speedport Entry 2
### Login process
Javascript code similar to the one used to generate the hashed password for the login POST call:
````
function hash(devpwd, challenge){
 var hash_pwd = devpwd+challenge;
 var password = sjcl.codec.hex.fromBits(sjcl.hash.sha256.hash(hash_pwd));
 return password;
}
````
### Reboot call

### More info
Read the content of [fickport.sh](fickport.sh) to know more about the command HTTP calls.

## Fickport
Reboot script

## DailyRunner
Script to run a the reboot daily

## Binaries
MIPS little endian binaries
