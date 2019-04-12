#!bin/sh
#
# MySQL Uninstall Script.
#
# The Script will uninstall Mysql-Related Dependencles, Condifguration
# And data. And it's not recoverable!
#
# In addition, mysql users and groups will also be removed!
#
# So,Make sure all relevant content is deprecated before executing the script!
#


# Find MySQL process pid and kill it by -9 

cur=$$
echo $cur
pids=( `ps aux |grep 'mysql' |grep -v grep|awk '{i=0; i=$2; print i}'`)
for pid in ${pids[@]}
do
  echo "MySQL Lib pid: $pid"
  if [ $cur -ne $pid ];then
        echo "Kill Mysql PID: $pid ..."
        kill -9 $pid
  fi
done


# Remove mysql-related dependencies

_mysqlLibs=$(rpm -qa |grep -i mysql)

for _lib in $_mysqlLibs
do
  #echo $_lib | grep -Eo '.*\.'| grep -Eo '.*[^\.]'
  _app=($(echo $_lib | grep -Eo ".*\." | grep -Eo ".*[^\.]"))
  echo "remove $_app ..."
  sudo yum remove -y $_app
done


# Remove mysql related files,folders and config

_mysqlFiles=$(find / -name "mysql*" -o -name "my.cnf*")

for _file in $_mysqlFiles
do
  if test -d $_file
  then
    echo "remove dir: $_file ..."
    sudo rm -rf $_file
  else
    echo "remove file: $_file ..."
    sudo rm -f $_file
  fi
done

# Remove mysql user and group
sudo userdel mysql -f
sudo groupdel mysql -f

echo "mysql user and group"

echo -e "\nCongratulation!"
echo "The Mysql Service Was Successfully Removed From The Machine!"
