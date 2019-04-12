#!bin/sh
#
# MySQL Uninstall Script.
#
# Find MySQL process pid and kill it by -9 
#

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

#
# Remove mysql-related dependencies
#
_mysqlLibs=$(rpm -qa |grep -i mysql)

for _lib in $_mysqlLibs
do
  #echo $_lib | grep -Eo '.*\.'| grep -Eo '.*[^\.]'
  _app=($(echo $_lib | grep -Eo ".*\." | grep -Eo ".*[^\.]"))
  echo "remove $_app ..."
  sudo yum remove -y $_app
done

#
# Remove mysql related files and folders
#
_mysqlFiles=$(find / -name mysql*)

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

echo "Congratulation!"
echo "The mysql service was successfully removed from the machine!"
