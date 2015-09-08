#!/usr/bin/env bash
set -o xtrace
set -o verbose
set -o errexit
#set -o nounset

### SYSTEM
# additional Ubuntu repositories
sed -i -e '/ partner/ s/# //' /etc/apt/sources.list         # Partner
sed -i -e '/extras.ubuntu.com/ s/# //' /etc/apt/sources.list            # Extras
# Google repo
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
# VirtualBox repo
sh -c "echo 'deb http://download.virtualbox.org/virtualbox/debian '$(lsb_release -cs)' contrib non-free' > /etc/apt/sources.list.d/virtualbox.list"
wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
# Docker repo
#echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list
#apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
# open source Silverlight counterpart repo
apt-add-repository -y ppa:pipelight/stable
apt-get update


### APPS
apt-get -y install curl tmux git vim irssi
# (headless) Virtualbox
apt-get -y install build-essential dkms VirtualBox-5.0
cd /tmp && wget http://download.virtualbox.org/virtualbox/5.0.2/Oracle_VM_VirtualBox_Extension_Pack-5.0.2-102096.vbox-extpack
VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-*
cd
# Docker (repo config included)
curl -sSL https://get.docker.com | sh
#DEFAULT_FORWARD_POLICY="DROP" -> "ACCEPT" /etc/default/ufw
#ufw reload
#ln -sf /usr/bin/docker.io /usr/local/bin/docker
#sed -i '$acomplete -F _docker docker' /etc/bash_completion.d/docker.io
#update-rc.d docker.io defaults
# Vagrant
wget https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.4_x86_64.deb
dpkg -i vagrant_1.7.4_x86_64.deb
apt-get -y install libxslt-dev libxml2-dev libvirt-dev zlib1g-dev

