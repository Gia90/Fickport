## Fritz! Device
> **The information in the following paragraphs strictly depend on the specific Fritz! device model and firmware version in use.**    

It's very likely that they you'll need to figure out other ways to be able to run custom code on different **Fritz! device**, you'll probabily need also to modify/adapt the provided scripts depending on the (usally limited) available tools in the target system.

### Fritz Fickbox Image
With **old enough Fritz!OS firmware versions**, it's possible to create a **"fake" firmware update image** and upload it to the Fritz device to run code on it.

The main features of the **Fritz!Fickport image** are described int the following [**Install script**](#install-script) paragraph.

**Fritz!Fickbox Image** content:
- **Install** script
- **Daily Runner** script
- **Binaries** folder

To generate the **Fritz!Fickport image**, run the following comand (_in the root of the project_)
````
cd fritz-image
echo "YOUR-DEV--PASSWORD-HERE" > devpwd.txt
./fritz-image.sh
````
The **Fritz!Fickport** image (**fickbox.tar**) should have been created in the "**fritz-image**" folder.

Now you can follow these instruction to install it to the Fritz! device:
- Login to the **Fritz! web interface** using your web browser (_http://FRITZ-IP_)
- Click on **"System" > "Update" > "FRITZ!OS-Datei"** (_last tab_)
- Follow the steps reported on this page:
  - Einstellungen sichern
  - Choose file (_select the generated **fickport.tar**_)
  - **Update starten**
- Wait till the upload finishes and then click "**Update fortsetzen**"
> _The instruction can differ depending on the Fritz! device model and firmware version used_

**Fickport should be now installed on your Fritz! device :D**

### Install script
This is the **entrypoint script** run when the fake update image is installed to the **Fritz! device**.
> [install](fritz-image/install)

The **main functionalities** implemented in it are:
- (Re)start **Fritz! services** required to make it work flawlessly (_without needing to reboot after the fake update_) 
- Start **telnet service**
- Install better, **fully-equipped busybox and wget** binaries
- **Prevent the automatic reboot** of the device (_usual behaviour after a fake update image installation_)

### Daily Runner script
Run a command everyday at a specific time, **without "crontab", "at" or even GNU coreutils "date" cli tools**.  
> [daily-runner.sh](fritz-image/daily-runner.sh)

This script is used to daily run "**fickport**" on the Fritz MIPS device and reboot the speedport2 every night.

### MIPS Binaries
MIPS little endian binaries

