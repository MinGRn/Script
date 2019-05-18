#!/bin/sh
#
# Redis Install Script. And The script Is Only Use For CentOS.
#
# You Can Get And Run The Script Following Command:
#
# Usage:
#   wget -qO- https://raw.githubusercontent.com/MinGRn/shell-script/master/redis/redis-install.sh | bash 
#    or
#   curl -fsSL https://raw.githubusercontent.com/MinGRn/shell-script/master/redis/redis-install.sh | bash
#

# Install libs
sudo yum -y install gcc automake autoconf libtool make wget

cd /opt

version=5.0.4

sudo wget https://github.com/antirez/redis/archive/$version.tar.gz -o ./redis-$version.tar.gz

tar xvf redis-$version.tar.gz

ln -s redis-$version redis

cd redis

sudo make MALLOC=libc

sudo make install

echo -e "\nCongratulation!"
echo "The Redis Service has been installed successfully!"

echo -e "\nYou Can Run 'redis-server /opt/redis/redis.conf' command start redis service !!!!"
