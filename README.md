# Fickport
## Introduction
The [Speedport Entry 2](https://de.wikipedia.org/wiki/Speedport) is an entry level modem/router produced by "Deutsche Telekom".  
This device is quite bad and its performances tend to degrade over time.  

The most common solution to this problem is made of several steps:
- Stand up
- Reach the **Speedport Entry 2**
- Pull the plug
- Wait few seconds
- Plug it back again
- Get back to what we were doing

Although this solution proved to be quite effective, it turned out to be also quite *annoying*.  
For this reason, the "**Fickport**" project was born :)

## How to use
There are different ways to use the **Fickport** tools.  
The next paragraphs describe the possible uses.

### Manually reboot
The simplest way to use the **Fickport** tools is to manually run the [**fickport.sh**](fickport.sh) bash script, everytime we start noticing the first signs of slowness in the network.
It's important to specify the correct **device password** for our **Speedport** router in the script, so that it will be able to succesfully login and reboot our beloved router. 

Unfortunately, this solution can be used only before the network becomes so slow to be actually unusable.
In this case, only 2 possibilities are left:
- Stand up and follow the "**most common solution**" steps written above
- Ask someone to perform the "**most common solution**" steps above

The real (*dirty*) solution would be preventing the performance degradation by daily rebooting the router.

### Auto daily reboot
If in your network there's an always alive and connected device, you could use it to periodically run the **fickport.sh** script and automatically reboot the router.  

In my real scenario, a "**Fritz!WLAN Repeater**" is always connected to the local network, so I will use it to run the "fickport.sh" rebooting script.

# Technical details
Wanna know more about techy stuff behind this project?    
**Read further!**
## Speedport Entry 2
Have I already said that the **Speedport Entry 2** is a shitty router?  
Let's talk about how it is working under the hood.
### Login process
Javascript code similar to the one used to generate the hashed password for the login POST call:
````
function hash(devpwd, challenge){
 var hash_pwd = devpwd+challenge;
 var password = sjcl.codec.hex.fromBits(sjcl.hash.sha256.hash(hash_pwd));
 return password;
}
````
The HTTP call is:
````
wget ...
````
### Reboot
The HTTP call to perform a reboot is the following one:
````
wget ...
````
### More info
Read the content of [fickport.sh](fickport.sh) to know more about the command HTTP calls.

## Fritz! Device
### Fritz Fickbox Image
It's possible to create a "fake" update image and upload it to the Fritz device to temporary (_unfortunately, till the next reboot_) run code on it.

...

Fritz! Fickbox Image content:
- **Install** script   
- **Daily Runner** script
- **Binaries** folder

### Install script
This is the entrypoint script run when the fake update image is installed to the Fritz device.
The step performed by it are:
- (Re)start fritz! services required to make it work flawlessly
- Make the binaries available in the system
- ...
- Prevent the automatic reboot of the device (usual behavioir after a fake update image installation)

### Daily Runner script
Run a command everyday at a specific time, without "crontab", "at" or even GNU coreutils "date" cli tools.
[daily-runner.sh](fritz-image/daily-runner.sh)

This script is used to run "fickport" on the Fritz MIPS device daily to reboot the shitty speedport every night.

### MIPS Binaries
MIPS little endian binaries
