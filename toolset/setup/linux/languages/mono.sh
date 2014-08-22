#!/bin/bash

RETCODE=$(fw_exists $IROOT/mono.installed)
[ ! "$RETCODE" == 0 ] || { return 0; }

echo "Installing mono from official Xamarin packages for Debian"

curl -s http://download.mono-project.com/repo/xamarin.gpg | sudo apt-key add -
echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/xamarin.list
sudo apt-get update
sudo apt-get -y install mono-complete mono-fastcgi-server4 || sudo apt-get -y remove monodoc-browser

echo "Installing RootCAs from Mozilla..."

echo -e 'y\ny\n' | certmgr -ssl https://nuget.org
mozroots --import --sync

echo -e 'y\ny\n' | sudo certmgr -ssl -m https://nuget.org
sudo mozroots --import --sync --machine

touch $IROOT/mono.installed
