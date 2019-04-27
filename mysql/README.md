# A Quick Guide to Using the MySQL Yum Repository

**Abstract**

The MySQL Yum repository provides RPM packages for installing the MySQL server, client, and other components on Linux platforms. The packages also upgrade and replace any third-party MySQL packages installed from the Linux distros' native software repositories, if replacements for them are available from MySQL.

The MySQL Yum repository supports the following Linux distributions:

- EL6 and EL7-based platforms (for example, the corresponding versions of Oracle Linux, Red Hat Enterprise Linux, and CentOS)

- Fedora 28 and 29

# Adding the MySQL Yum Repository

First, add the MySQL Yum repository to your system's repository list. Follow these steps:

- Go to the download page for MySQL Yum repository at https://dev.mysql.com/downloads/repo/yum/.

- Select and download the release package for your platform.

- Install the downloaded release package with the following command, replacing *platform-and-version-specific-package-name* with the name of the downloaded package:

```shell
shell> sudo rpm -iUvh platform-and-version-specific-package-name.rpm
```

For example, for version **n** of the package for EL6-based systems, the command is:

```shell
shell> sudo rpm -Uvh mysql80-community-release-el6-n.noarch.rpm
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

```shell
shell> sudo wget https://dev.mysql.com/get/mysql80-community-release-el7-2.noarch.rpm
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