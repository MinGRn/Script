#!/bin/sh
#
# MySQL Install Script. And The script Is Only Use For CentOS.
#
# You Can Get And Run The Script Following Command:
#
# Usage:
#   wget -qO- https://raw.githubusercontent.com/MinGRn/Script/master/mysql/install/install-mysql-centos-v8.sh | bash
#     or
#   curl -fsSL https://raw.githubusercontent.com/MinGRn/Script/master/mysql/install/install-mysql-centos-v8.sh | bash
#
# The Script will uninstall Mysql-Related Dependencles, Condifguration And data Before Install it. And it's not recoverable!
#
# In addition, mysql users and groups will also be removed!
#
# So,Make sure all relevant content is deprecated before executing the script!
#

# Install wget util and yum util
sudo yum install -y wget \ 
     yum install -y yum-utils

# uninstall if you have already installed it.
sudo wget -qO- https://raw.githubusercontent.com/MinGRn/Script/master/mysql/uninstall/uninstall-mysql.sh | bash

# obtain mysql rpm package
sudo wget https://dev.mysql.com/get/mysql80-community-release-el7-2.noarch.rpm

# install rpm resources
sudo rpm -ivh mysql80-community-release-el7-2.noarch.rpm

# When using the MySQL Yum repository, the latest GA release of MySQL is selected for installation by default. 
# Use the following command to see all the subrepositories in the MySQL Yum repository, and see which of them 
# are enabled or disabled (for dnf-enabled systems, replace yum in the command with dnf):
#
# Usage:
#  yum repolist all | grep mysql
#     or
#  dnf repolist all | grep mysql

echo "See all the subrepositories in the MySQL Yum repository"
yum repolist all | grep mysql

# The Script will install mysql v8.0 by default(To install the latest release from the latest GA series, no 
# configuration is needed. ).
#
# To install the latest release from a specific series other than the latest GA series, disable the subrepository 
# for the latest GA series and enable the subrepository for the specific series before running the installation 
# command.
#
# If your platform supports the yum-config-manager(`yum install -y yum-utils`) or dnf config-manager command, you 
# can do that by issuing, for example, the following commands, which disable the subrepository for the 8.0 series 
# and enable the one for the 5.7 series; for platforms that are not dnf-enabled:
#
# Usage:
#  sudo yum-config-manager --disable mysql80-community
#  sudo yum-config-manager --enable mysql57-community
#
# For dnf-enabled platforms:
#
#  sudo dnf config-manager --disable mysql80-community
#  sudo dnf config-manager --enable mysql57-community

# Verify that the correct subrepositories have been enabled and disabled by running the following command and checking 
# its output (for dnf-enabled systems, replace yum in the command with dnf):
# 
# Usage:
#
#  yum repolist enabled | grep mysql

echo "Verify that the correct subrepositories have been enabled and disabled"
yum repolist enabled | grep mysql

#####################################################################################################################

# Installl Mysql
# This installs the package for the MySQL server, as well as other required packages.

sudo yum install -y mysql-community-server

# If the installation is successful, start the service using the following command.
#
# Usage:
#  sudo service mysqld start
#
# For EL7-based platforms, this is the preferred command(recommended):
#
#  sudo systemctl start mysqld.service
#
# If you want start mysqld service when you login, run following command:
#
#  sudo systemctl enable mysqld.service

sudo systemctl start mysqld.service

# You can check the status of the MySQL server with the following command:
#
# Usage:
#  sudo service mysqld status
#
# For EL7-based platforms, this is the preferred command:
#
#  sudo systemctl status mysqld.service

sudo systemctl status mysqld.service

# The first time the service is started is when a temporary root user password is created.
# To reveal it, use the following command:
#
#  sudo grep 'temporary password' /var/log/mysqld.log

echo "The temp root password:"
echo -e "\n"
sudo grep 'temporary password' /var/log/mysqld.log
echo -e "\n"

echo "Set password for yout MYSQl instance and securing the mysql, You need to use the above temporary password"

mysql_secure_installation

echo -e "\nCongratulation!"
echo "The Mysql Service has been installed successfully!"
echo "Now, Log in and start the trip!"
echo -e "\n"

mysql -u root -p

###############################################################################################################

# The following is a reference example, You need to log in to test.
#
# Login mysql:
#
#  Usage:
#    mysql -u root -p
#
# Check the MySQL engine using the following commands. 
# 
#  Usage:
#    SHOW GLOBAL VARIABLES LIKE 'storage_engine';
#
# Create a temp user and a database from MySQL CLI.
#
#  Usage:
#    CREATE USER 'tempuser'@'localhost' IDENTIFIED BY 'temppassword';
#
# Create a database.
#
#  Usage:
#    CREATE DATABASE test;
#
# Grant all privileges on test database to the tempuser user.
#
#  Usage:
#    GRANT ALL PRIVILEGES ON test.* TO 'tempuser'@'localhost';
#
#
# You can also modify the file `/etc/my.cnf` to configure mysql related Settings
