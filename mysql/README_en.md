# A Quick Guide to Using the MySQL Yum Repository

**Abstract**

The MySQL Yum repository provides RPM packages for installing the MySQL server, client, and other components on Linux platforms. The packages also upgrade and replace any third-party MySQL packages installed from the Linux distros' native software repositories, if replacements for them are available from MySQL.

The MySQL Yum repository supports the following Linux distributions:

- EL6 and EL7-based platforms (for example, the corresponding versions of Oracle Linux, Red Hat Enterprise Linux, and CentOS)

- Fedora 28 and 29

# Uninstall Old Version

If you have installed it before, uninstall it first!

You can just run following command:

```
wget -qO- https://raw.githubusercontent.com/MinGRn/shell-script/master/mysql/uninstall/uninstall-mysql.sh | bash
  or
curl -fsSL https://raw.githubusercontent.com/MinGRn/shell-script/master/mysql/uninstall/uninstall-mysql.sh | bash
```

# Adding the MySQL Yum Repository

First, add the MySQL Yum repository to your system's repository list. Follow these steps:

- Go to the download page for MySQL Yum repository at https://dev.mysql.com/downloads/repo/yum/.

- Select and download the release package for your platform.

- Install the downloaded release package with the following command, replacing *platform-and-version-specific-package-name* with the name of the downloaded package:

```
# sudo rpm -iUvh platform-and-version-specific-package-name.rpm
```

For example, for version **n** of the package for EL6-based systems, the command is:

```
# sudo rpm -iUvh mysql80-community-release-el6-n.noarch.rpm
```

> **Note**
>
> Once the release package is installed on your system, any system-wide update by the **yum update** command (or **dnf upgrade** for dnf-enabled systems) will automatically upgrade MySQL packages on your system and also replace any native third-party packages, if Yum finds replacements for them in the MySQL Yum repository. See [Upgrading MySQL with the MySQL Yum Repository](https://dev.mysql.com/doc/mysql-yum-repo-quick-guide/en/index.html#repo-qg-yum-upgrading) and [Replacing a Native Third-Party Distribution of MySQL](https://dev.mysql.com/doc/mysql-yum-repo-quick-guide/en/index.html#repo-qg-yum-replacing) for details.

**MySQL Yum Repository**

In traditionally, you can download the latest *mysql yum repo* at https://dev.mysql.com/downloads/repo/yum/. For example, The current downloadable version is *MySql v8* :

```
https://dev.mysql.com/get/mysql80-community-release-el7-2.noarch.rpm
```

You can get it by the following command:

```
# sudo wget https://dev.mysql.com/get/mysql80-community-release-el7-2.noarch.rpm
```

The Latest MySQL Yum repository includes the latest versions of:

- MySQL 8.0
- MySQL 5.7
- MySQL 5.6
- MySQL Cluster 8.0 (DMR)
- MySQL Cluster 7.6
- MySQL Cluster 7.5
- MySQL Workbench
- MySQL Router
- MySQL Shell
- MySQL Connector/C++
- MySQL Connector/J
- MySQL Connector/ODBC
- MySQL Connector/Python

So, you can install mysql 5.0+ as well. But It will install MySQL 8.0 by default.

# Selecting a Release Series

When using the MySQL Yum repository, the latest GA release of MySQL is selected for installation by default. If this is what you want, you can skip to the next step, [Installing MySQL with Yum]().

Within the MySQL Yum repository (https://repo.mysql.com/yum/), different release series of the MySQL Community Server are hosted in different subrepositories. The subrepository for the latest GA series (currently MySQL 8.0) is enabled by default, and the subrepositories for all other series (for example, the MySQL 5.7 series) are disabled by default. Use this command to see all the subrepositories in the MySQL Yum repository, and see which of them are enabled or disabled (for dnf-enabled systems, replace **yum** in the command with **dnf**):

```
# yum repolist all | grep mysql
```

e.g.:

```
# yum repolist all | grep mysql

mysql-cluster-7.5-community/x86_64 MySQL Cluster 7.5 Community      禁用
mysql-cluster-7.5-community-source MySQL Cluster 7.5 Community - So 禁用
mysql-cluster-7.6-community/x86_64 MySQL Cluster 7.6 Community      禁用
mysql-cluster-7.6-community-source MySQL Cluster 7.6 Community - So 禁用
mysql-connectors-community/x86_64  MySQL Connectors Community       启用:    105
mysql-connectors-community-source  MySQL Connectors Community - Sou 禁用
mysql-tools-community/x86_64       MySQL Tools Community            启用:     89
mysql-tools-community-source       MySQL Tools Community - Source   禁用
mysql-tools-preview/x86_64         MySQL Tools Preview              禁用
mysql-tools-preview-source         MySQL Tools Preview - Source     禁用
mysql55-community/x86_64           MySQL 5.5 Community Server       禁用
mysql55-community-source           MySQL 5.5 Community Server - Sou 禁用
mysql56-community/x86_64           MySQL 5.6 Community Server       禁用
mysql56-community-source           MySQL 5.6 Community Server - Sou 禁用
mysql57-community/x86_64           MySQL 5.7 Community Server       禁用
mysql57-community-source           MySQL 5.7 Community Server - Sou 禁用
mysql80-community/x86_64           MySQL 8.0 Community Server       启用:     99  ==> The Latest Version Is Enable By Default
mysql80-community-source           MySQL 8.0 Community Server - Sou 禁用
```

To install the latest release from the latest GA series, no configuration is needed. To install the latest release from a specific series other than the latest GA series, disable the subrepository for the latest GA series and enable the subrepository for the specific series before running the installation command. If your platform supports the **yum-config-manager** or **dnf config-manager** command, you can do that by issuing, for example, the following commands, which disable the subrepository for the 8.0 series and enable the one for the 5.7 series; for platforms that are not dnf-enabled:

```
# sudo yum-config-manager --disable mysql80-community
# sudo yum-config-manager --enable mysql57-community
```

For dnf-enabled platforms:

```
# sudo dnf config-manager --disable mysql80-community
# sudo dnf config-manager --enable mysql57-community
```

Besides using **yum-config-manager** or the **dnf config-manager command**, you can also select a series by editing manually the `/etc/yum.repos.d/mysql-community.repo` file. This is a typical entry for a release series' subrepository in the file:

```
# cat /etc/yum.repos.d/mysql-community.repo 

[mysql55-community]
name=MySQL 5.5 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.5-community/el/7/$basearch/
enabled=0
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql

[mysql56-community]
name=MySQL 5.6 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.6-community/el/7/$basearch/
enabled=0
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql

# Enable to use MySQL 5.7
[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/
enabled=0
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql

[mysql80-community]
name=MySQL 8.0 Community Server
baseurl=http://repo.mysql.com/yum/mysql-8.0-community/el/7/$basearch/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql

......
```

Find the entry for the subrepository you want to configure, and edit the `enabled` option. Specify `enabled=0` to **disable** a subrepository, or `enabled=1` to **enable** a subrepository. For example, to install MySQL 5.7, make sure you have `enabled=0` for the above subrepository entry for MySQL 8.0, and have `enabled=1` for the entry for the 5.7 series:


```
# Enable to use MySQL 5.7
[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/
enabled=1  ==> enable
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql

[mysql80-community]
name=MySQL 8.0 Community Server
baseurl=http://repo.mysql.com/yum/mysql-8.0-community/el/7/$basearch/
enabled=0  ==> disable
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql
```

You should only enable subrepository for one release series at any time. When subrepositories for more than one release series are enabled, the latest series will be used by Yum.

Verify that the correct subrepositories have been enabled and disabled by running the following command and checking its output (for dnf-enabled systems, replace **yum** in the command with **dnf**):

```
# yum repolist enabled | grep mysql

mysql-connectors-community/x86_64 MySQL Connectors Community                 105
mysql-tools-community/x86_64      MySQL Tools Community                       89
mysql57-community/x86_64          MySQL 5.7 Community Server                 347.  ==> mysql 5.7 is enabled
```

# Installing MySQL

Install MySQL by the following command (for dnf-enabled systems, replace **yum** in the command with **dnf**):

```
# sudo yum install -y mysql-community-server
```

This installs the package for the MySQL server, as well as other required packages.

# Starting the MySQL Server

- Start the MySQL server with the following command:

```
# sudo service mysqld start
```

For EL7-based platforms, this is the preferred command:

```
# sudo systemctl start mysqld.service
```

- You can check the status of the MySQL server with the following command:

```
# sudo service mysqld status
```

For EL7-based platforms, this is the preferred command:

```
# sudo systemctl status mysqld.service
```

- You can make it automate enable when reboot.

```
# sudo service mysqld enable
```

For EL7-based platforms, this is the preferred command:

```
# sudo systemctl enable mysqld.service
```

Now, a superuser account `'root'@'localhost'` is created. A password for the superuser is set and stored in the error log file. To reveal it, use the following command:

```
# sudo grep 'temporary password' /var/log/mysqld.log
```

# Securing the MySQL Installation(for MySQL 5.6 only)

The program `mysql_secure_installation` allows you to perform important operations like setting the root password, removing anonymous users, and so on. Always run it to secure your MySQL 5.6 installation::

```
# mysql_secure_installation
```

It is important to remember the root password you set. See [mysql_secure_installation — Improve MySQL Installation Security](https://dev.mysql.com/doc/refman/8.0/en/mysql-secure-installation.html) for details.

Do not run `mysql_secure_installation` after an installation of MySQL 5.7 or higher, as the function of the program **has already been performed by the Yum repository installation**.

# Login And Setting

```
# mysql -uroot -p
```

### Update Root User Password Use Following Command:

```
mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'MyNewPass4!';
```

**Your password does not satisfy the current policy requirements ?**

> **Note:** If you fire time login, you need update password first, exit mysql client and run `mysql_secure_installation` command.
>
> **You can check out the demo video below to see how mysql is installed！**

When you modify or create a user password when prompted this information, you can view `validate_password` to modify the corresponding authentication information :

```
mysql> SHOW VARIABLES LIKE 'validate_password%';

+--------------------------------------+--------+
| Variable_name                        | Value  |
+--------------------------------------+--------+
| validate_password_check_user_name    | OFF    |
| validate_password_dictionary_file    |        |
| validate_password_length             | 8      |  ==> length verify
| validate_password_mixed_case_count   | 1      |
| validate_password_number_count       | 1      |
| validate_password_policy             | MEDIUM |  ==> update to low
| validate_password_special_char_count | 1      |
+--------------------------------------+--------+
```

Modify the validation information that you want to modify, Here is an example:

```
mysql> set global validate_password_policy=LOW;
mysql> set global validate_password_length=6;

mysql> SHOW VARIABLES LIKE 'validate_password%';
+--------------------------------------+-------+
| Variable_name                        | Value |
+--------------------------------------+-------+
| validate_password_check_user_name    | OFF   |
| validate_password_dictionary_file    |       |
| validate_password_length             | 6     |
| validate_password_mixed_case_count   | 1     |
| validate_password_number_count       | 1     |
| validate_password_policy             | LOW   |
| validate_password_special_char_count | 1     |
+--------------------------------------+-------+
```

Now, You can set a simple password such as `admin123`


**Extension：**

+ `validate_password_length:` set password length

+ `validate_password_dictionary_file:` Specify the file path for password validation

+ `validate_password_mixed_case_count: `The entire password should contain at least the total number of upper/lower case letters

+ `validate_password_number_count:` The whole password should contain at least the number of Arabic numerals

+ `validate_password_policy` Specifies the strength verification level for the password, default is `MEDIUM`
s
+ `validate_password_policy`:
  - `0/LOW:` Verify only the length
  - `1/MEDIUM:` Verify length, number, case, and special characters
  - `2/STRONG:` Validates length, number, case, special character, dictionary file


#### Create A New User Use Following Command:

```
mysql> CREATE USER 'NewUser'@'localhost' IDENTIFIED BY 'NewUserPassword';
```

#### Create A New Databases Use Following Command:

```
mysql> CREATE DATABASE NewDatabaseName;
```

#### Grant **all privileges on `NewDatabaseName` database** to the `NewUser` user Use Following Command:

```
mysql> RANT ALL PRIVILEGES ON NewDatabaseName.* TO 'NewUser'@'localhost';
```

#### Grant **all databases privileges** to the `NewUser` user Use Following Command:

```
mysql> RANT ALL PRIVILEGES ON '%' TO 'NewUser'@'localhost';
```

**Not**

If you want a user to be able to login to mysql remotely, You need set the Host with `%`:

```
mysql> show databases;

+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+


mysql> use mysql;

mysql> select user,host from user;
+------------------+-----------+
| user             | host      |
+------------------+-----------+
| mysql.infoschema | localhost |
| mysql.session    | localhost |
| mysql.sys        | localhost |
| root             | localhost |
+------------------+-----------+
```

Now, Update root user, and set host is `%`;

```
mysql> update user set host='%' where user='root' and host='localhost';
mysql> flush privileges;
```

Now, You can login mysql server use root user by remote host:

```
mysql> select user,host from user;

+------------------+-----------+
| user             | host      |
+------------------+-----------+
| root             | %         |
| mysql.infoschema | localhost |
| mysql.session    | localhost |
| mysql.sys        | localhost |
+------------------+-----------+
```

[![Demo video](https://asciinema.org/a/244660.svg)](https://asciinema.org/a/244660)