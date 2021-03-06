# Ubuntu OverSSH Reinstallation

![ubuntu 18.04 bionic](https://img.shields.io/badge/ubuntu%2018.04%20bionic-tested-green.svg "ubuntu 18.04 bionic")
![ubuntu 16.04 trusty](https://img.shields.io/badge/ubuntu%2016.04%20trusty-tested-green.svg "ubuntu 16.04 trusty")
![MIT License](https://img.shields.io/badge/license-MIT-ff9900.svg "MIT License")

If your ISP/Datacenter dosn't provide standard or trusted iso for your server. Get ugly server from it with installed version of Ubuntu server.
Or your data is so important and you [Full System Encryption](https://help.ubuntu.com/community/ManualFullSystemEncryption) method for encrypt all data stored on your vps or server. If ISP just clone your vps harddrive? If just change raid HDD drive on dedicate server. How do you deal with it? Simple just partion encrypted drives and enjoy your secure server.

I have same situation installed ubuntu has bad partition table or huge list of stupid package installed. Datacenter network is my primary concern or it's really cheap price but administrators dosn't care. What should i do? That's my way to solve this issue easily.

Ask them to install ubuntu server what ever is it. re install it over ssh, repartition and get clean installation of ubuntu server.

Create your own netiso and reinstall it over ssh. You can partion yor server as you desire. And set more configuration using [ubuntu preseed](https://help.ubuntu.com/lts/installation-guide/amd64/apbs02.html) just over ssh; no kvm/ipmi/vnc required.

It's simple, create modified iso based on your network and preseed url file and continue installation over ssh.

I use [Minimal CD](https://help.ubuntu.com/community/Installation/MinimalCD) because it's small and get most packages from ubuntu repository so you server after installation is fully updated.

## 1. Wizard

### 1.1 Download this repo and extracet it.

```bash
wget https://gitlab.com/AASAAM/ubuntu-overssh-reinstallation/-/archive/master/ubuntu-overssh-reinstallation-master.tar.gz
tar -xf ubuntu-overssh-reinstallation-master.tar.gz
cd ubuntu-overssh-reinstallation-master/
```

### 1.2 Preseed Server PHP script (optional)

Upload `preseed-server/*` to webroot of desire webserver and set `PRESEED_SERVER` env variable.
With this simple variable preseed file will be uploaded to server and checked via chechsum for validation.

In `index.php` file you can change http auth user and password.

```bash
export PRESEED_SERVER=http://ubuntu-preseed.example.tld
```

Or via http auth config:

```bash
export PRESEED_SERVER=http://preseedusr:preseedpass@ubuntu-preseed.example.tld
```

### 1.3 Run wizard

```bash
./wizard.sh
```

This script will be help you to create config and preseed file. `config` and `preseed.cfg` will be generate on `tmp` directory.

## 2. Make ISO

This script will be create your modified iso file based on network and preseed file.

```bash
./setup-iso.sh
```

## 3. Update GRUB

Your iso is ready and you can update grub for load the iso for first priority.

```bash
./setup-update-grub.sh
```

## 4. Reboot and wait for it

Reboot the server.

```bash
reboot
```

Wait to server reset, may take a few minites depend on your server manufacturer.

## 5. Continue installation

You can ssh login for installation, example: `installer@192.168.1.1`
