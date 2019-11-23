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

- **Update Root User Password Use Following Command:**

```
mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'MyNewPass';
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


- **Create A New User Use Following Command:**

```
mysql> CREATE USER 'NewUser'@'localhost' IDENTIFIED BY 'NewUserPassword';
```

- **Create A New Databases Use Following Command:**

```
mysql> CREATE DATABASE NewDatabaseName;
```

- **Grant `all privileges` on `NewDatabaseName` database to the `NewUser` user Use Following Command:**

```
mysql> RANT ALL PRIVILEGES ON NewDatabaseName.* TO 'NewUser'@'localhost';
```

- **Grant `all databases privileges` to the `NewUser` user Use Following Command:**

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

# Migration data directory

YUM 安装方式使用的默认数据存储目录是：`/var/lib/mysql`，如果在前面步骤按顺序走完后你会看到该文件夹有类似如下数据文件：

```bash
$ ls /var/lib/mysql

auto.cnf    client-cert.pem  ibdata1      ibtmp1              private_key.pem  server-key.pem
ca-key.pem  client-key.pem   ib_logfile0  mysql               public_key.pem   sys
ca.pem      ib_buffer_pool   ib_logfile1  performance_schema  server-cert.pem
```

在实际应用中，我们不太可能会直接使用默认的数据目录存储数据，因为不利于管理。现在就来看看如何修改数据存储目录！

MySQL 的服务启动配置文件通常为 `my.cnf`，并存储在 `/etc` 目录下。但各个版本也可能存在差异，所以我们要首先看下当前版本配置文件名是什么，存储在哪里。

在命令终端输入 `mysql --help` 查看帮助命令，你会在输出信息中看到有如下一段信息：

```
Default options are read from the following files in the given order:
/etc/my.cnf /etc/mysql/my.cnf /usr/etc/my.cnf ~/.my.cnf
```

这段提示你：当前版本的配置文件名称为 `my.cnf`。按优先级别存储的目录分别是 `/etc`、`/etc/mysql`、`/usr/etc`以及当前用户目录（配置文件名为 `.my.cnf`）。

所以，我们以 `/etc` 为主，将配置文件放置在该目录（通常使用 `yum` 安装完成后该目录下会有一个默认的 `my.cnf` 文件，如果没有则创建一个 `my.cnf` 文件即可）。现在编辑该文件将 `datadir` 数据目录值修改为 `/opt/mysql/data`（注意，编辑时应该使用 `sudo` 超级管理员命令，否则权限为只读权限）。

```bash
$ sudo vim /etc/my.cnf
```

修改后的内容如下所示：

```
# For advice on how to change settings please see
# http://dev.mysql.com/doc/refman/5.7/en/server-configuration-defaults.html

[mysqld]
#
# Remove leading # and set to the amount of RAM for the most important data
# cache in MySQL. Start at 70% of total RAM for dedicated server, else 10%.
# innodb_buffer_pool_size = 128M
#
# Remove leading # to turn on a very important data integrity option: logging
# changes to the binary log between backups.
# log_bin
#
# Remove leading # to set options mainly useful for reporting servers.
# The server defaults are faster for transactions and fast SELECTs.
# Adjust sizes as needed, experiment to find the optimal values.
# join_buffer_size = 128M
# sort_buffer_size = 2M
# read_rnd_buffer_size = 2M
datadir=/opt/mysql/data
socket=/var/lib/mysql/mysql.sock

# Disabling symbolic-links is recommended to prevent assorted security risks
symbolic-links=0

log-error=/var/log/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid
```

**注意：** `datadir=/opt/mysql/data` 这段就是数据目录的配置。我们直接修改数据存储目录，所以该目录下没有任何数据，如果你想继续沿用之前的数据，只需要将之前的数据文件拷贝到该目录下即可！当前演示需要，不会放置任何数据。另外，先将已存在的 `/var/log/mysqld.log` 日志文件删除，以免影响后续操作！

修改完成后进行保存，现在来看下当前目录的归属用户与权限：

```bash
$ ll /opt/mysql

drwxr-xr-x. 5 root root  4096 11月 23 13:45 data
```

所以，我们还需要修改该文件的归属用户权限。`YUM` 命令安装 `MySQL` 通常会默认创建 `mysql` 用户和 `mysql` 用户组。我们可以分别看下 `/etc` 下的 `passwd` 文件内容和 `group` 内容：

> `/etc` 目录下 `passwd` 文件存储的是用户信息，`group` 文件存储的是用户组信息。

```bash
$ cat /etc/passwd | grep mysql
mysql:x:27:27:MySQL Server:/var/lib/mysql:/bin/false

$ cat /etc/group | grep mysql
mysql:x:27:
```

所以，我们现在就使用 `chown` 命令将 `/opt/mysql` 文件夹及文件归属给 `mysql` 用户和 `mysql` 用户组：

```bash
$ chown -R mysql:mysql /opt/mysql
```

现在再来看下目录权限：

```bash
$ ll /opt/mysql

drwxr-xr-x. 5 mysql mysql  4096 11月 23 13:45 data
```

所有权限准备就绪后开始启动 `MySQL` 服务：

```bash
# 终止 MySQL 服务
$ systemctl stop mysqld.service

# 启动 MySQL 服务
$ systemctl start mysqld.service
```

如果在启动过程中输出如下信息即表示没有启动成功：

```
Job for mysqld.service failed because the control process exited with error code. See "systemctl status mysqld.service" and "journalctl -xe" for details.
```

执行命令 `journalctl -xe` 或者直接查看 `/var/log/mysqld.log` 你会看到类似如下的错误信息：

```
[Warning] Can't create test file /opt/mysql/data/localhost.lower-test
```

如果出现该信息继续阅读 [Can't create test file xxx.lower-test](#) ，如果没有请直接跳过！

## Can't create test file xxx.lower-test

看到该错误信息后，你各种度娘、谷歌、stackoverflow，一顿操作猛如虎，回头一看你会发现，所有的答案都指向 `selinux`。告诉你，需要修改 `/etc/selinux/config` 配置文件，将该文件中的 `SELINUX=enforcing` 修改为 `SELINUX=disabled`，然后 `reboot` 即可！

事实确实如此，那么 `selinux` 到底是什么？这个我们需要先弄明白！

**SELinux是什么?**

SELinux，Security Enhanced Linux 的缩写，也就是安全强化的 Linux，是由美国国家安全局（NSA）联合其他安全机构（比如 SCC 公司）共同开发的，旨在增强传统 Linux 操作系统的安全性，解决传统 Linux 系统中自主访问控制（DAC）系统中的各种权限问题（如 root 权限过高等）。

SELinux 项目在 2000 年以 GPL 协议的形式开源，当 Red Hat 在其 Linux 发行版本中包括了 SELinux 之后，SELinux 才逐步变得流行起来。现在，SELinux 已经被许多组织广泛使用，几乎所有的 Linux  内核 2.6 以上版本，都集成了 SELinux 功能。
对于 SELinux，初学者可以这么理解，它是部署在 Linux 上用于增强系统安全的功能模块。

我们知道，传统的 Linux 系统中，默认权限是对文件或目录的所有者、所属组和其他人的读、写和执行权限进行控制，这种控制方式称为自主访问控制（DAC）方式；而在 SELinux 中，采用的是强制访问控制（MAC）系统，也就是控制一个进程对具体文件系统上面的文件或目录是否拥有访问权限，而判断进程是否可以访问文件或目录的依据，取决于 SELinux 中设定的很多策略规则。

说到这里，读者有必要详细地了解一下这两个访问控制系统的特点：

- 自主访问控制系统（Discretionary Access Control，DAC）是 Linux 的默认访问控制方式，也就是依据用户的身份和该身份对文件及目录的 rwx 权限来判断是否可以访问。不过，在 DAC 访问控制的实际使用中我们也发现了一些问题：
  1. root 权限过高，rwx 权限对 root 用户并不生效，一旦 root 用户被窃取或者 root 用户本身的误操作，都是对 Linux 系统的致命威胁。
  2. Linux 默认权限过于简单，只有所有者、所属组和其他人的身份，权限也只有读、写和执行权限，并不利于权限细分与设定。
  3. 不合理权限的分配会导致严重后果，比如给系统敏感文件或目录设定 777 权限，或给敏感文件设定特殊权限——SetUID 权限等。

- 强制访问控制（Mandatory Access Control，MAC）是通过 SELinux 的默认策略规则来控制特定的进程对系统的文件资源的访问。也就是说，即使你是 root 用户，但是当你访问文件资源时，如果使用了不正确的进程，那么也是不能访问这个文件资源的。

这样一来，SELinux 控制的就不单单只是用户及权限，还有进程。每个进程能够访问哪个文件资源，以及每个文件资源可以被哪些进程访问，都靠 SELinux 的规则策略来确定。

> 注意，在 SELinux 中，Linux 的默认权限还是有作用的，也就是说，一个用户要能访问一个文件，既要求这个用户的权限符合 rwx 权限，也要求这个用户的进程符合 SELinux 的规定。

不过，系统中有这么多的进程，也有这么多的文件，如果手工来进行分配和指定，那么工作量过大。所以 SELinux 提供了很多的默认策略规则，这些策略规则已经设定得比较完善，我们稍后再来学习如何查看和管理这些策略规则。

为了使读者清楚地了解 SELinux 所扮演的角色，这里举一个例子，假设 apache 上发现了一个漏洞，使得某个远程用户可以访问系统的敏感文件（如 /etc/shadow）。如果我们的 Linux 中启用了 SELinux，那么，因为 apache 服务的进程并不具备访问 /etc/shadow 的权限，所以这个远程用户通过 apache 访问 /etc/shadow文件就会被 SELinux 所阻挡，起到保护 Linux 系统的作用。

以上来源：[SELinux管理](http://c.biancheng.net/view/1147.html)

----

所以，现在现在禁用 `selinux`。

```bash
$ cat /etc/selinux/config 

# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#     enforcing - SELinux security policy is enforced.
#     permissive - SELinux prints warnings instead of enforcing.
#     disabled - No SELinux policy is loaded.
SELINUX=enforcing
# SELINUXTYPE= can take one of three values:
#     targeted - Targeted processes are protected,
#     minimum - Modification of targeted policy. Only selected processes are protected. 
#     mls - Multi Level Security protection.
SELINUXTYPE=targeted 
```

说下 SELINUX 三个值的释义：

- `enforcing` 执行保护
- `permissive` 不执行保护只记录越权访问
- `disabled` 禁用 selinux

将 SELINUX 修改为 `disabled` 后，重启机器（`reboot`）确实能够启动 MySQL 服务了。接下载就按照之前的步骤获取初始密码接着走先去即可！

但是！如果直接禁用了 `SELINUX`，机器的安全将无法得到保障！所以，我们应该仅仅开放 `/opt/mysql` 目录的权限！先将 `SELINUX` 值修改回 `enforcing`。

Linux 有一个工具：`semanage`，该工具就是用来管理 `selinux` 的，那么 `semanage` 是什么？

1. semanage是一个软件中的一部分，
2. 可在linux中用命令行的方式使用
3. 它可以管理SELinux

**SELinux的默认设置**

默认情况下，最小化安装的CentOS，SELinux是开启的。SELinux默认情况下，只允许非root权限用户，使用几个固定端口（包括http端口和其他协议的端口）。
  
被默认可以使用的http端口如下：可使用命令 `semanage port -l | grep http_port_t` 查看，结果如下：

```bash
$ semanage port -l | grep http_port_t

http_port_t                    tcp      80, 81, 443, 488, 8008, 8009, 8443, 9000
pegasus_http_port_t            tcp      5988
```

看下如下问题：

`yum` 安装的 `nginx`，创建了 `nginx` 用户，来进行系统资源的使用，`nginx` 用户是没有 `root` 权限的。

所以，它无法监听 除了默认可以使用的那些 http 端口，因为SELinux不允许

解决方法：

为了保证安全，SELinux是不能关闭的，所以，只能让SELinux加入通行规则，开放一些端口，让所有用户(当然也可以是指定的用户)能够使用。

所以，我们也应该为 MySQL 服务增加一些通行规则！

先来安装 `semanage`：

我们可以执行如下命令查看该命令被包含在什么软件包中

```bash
$ yum provides /usr/sbin/semanage
```

输出信息如下：

```
已加载插件：fastestmirror
Loading mirror speeds from cached hostfile
 * base: mirrors.163.com
 * extras: mirrors.163.com
 * updates: mirrors.aliyun.com
policycoreutils-python-2.5-33.el7.x86_64 : SELinux policy core python utilities
源    ：base
匹配来源：
文件名    ：/usr/sbin/semanage



policycoreutils-python-2.5-33.el7.x86_64 : SELinux policy core python utilities
源    ：@base
匹配来源：
文件名    ：/usr/sbin/semanage
```

所以，我们需要安装 `policycoreutils-python` 工具：

```bash
$ yum install -y policycoreutils-python
```

安装完成后，执行 `semanage -help` 帮助命令查看如何使用，这里不做具体说明了！现在就来为 MySQL 设置同行规则：

我们的 MySQL 数据目录是 `/opt/mysql`，所以执行命令如下所示：

```bash
$ sudo semanage fcontext --add --type mysqld_db_t "/opt/mysql(/.*)?"
```

> **注意：** `--typt` 值必定要是 `mysqld_db_t`。

执行完成后，继续执行如下命令：

```bash
$ restorecon -rv /opt/mysql
```

> restorecon 是什么命令，不做具体科普了，可以查阅一下 SELinux 安全上下文修改（`chcon`、`restorecon`、`semanage`）相关命令！

执行完成后，即可使用 `systemctl start mysqld.service` 了，执行完成后我们需要查看 `/var/log/mysqld.log` 文件查看 MySQL 初始 root 密码，然后登陆修改，完成剩余操作即可！

至此，YUM 安装方式数据目录就修改完成了！