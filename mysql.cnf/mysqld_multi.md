# mysqld_multi

## 安装mysql

    安装过程省略

## 配置[mysqld_multi]

    参考 `mysqld_multi --example` 或 my_multi.cnf 配置文件

## 拷贝数据目录

```sh
# cp /var/lib/mysql /path/to/mysql—data-dir
cp /var/lib/mysql /var/lib/mysql33061
cp /var/lib/mysql /var/lib/mysql33062
cp /var/lib/mysql /var/lib/mysql33063
cp /var/lib/mysql /var/lib/mysql33064
chown mysql.mysql /var/lib/mysql* -R
```

## 查看状态 启动

```sh
mysqld_multi --defaults-extra-file=/etc/mysql/my.cnf report

# Reporting MySQL servers
# MySQL server from group: mysqld33061 is not running
# MySQL server from group: mysqld33062 is not running
# MySQL server from group: mysqld33063 is not running
# MySQL server from group: mysqld33064 is not running
```

```sh
mysqld_multi --defaults-extra-file=/etc/mysql/my.cnf start

# Reporting MySQL servers
# MySQL server from group: mysqld33061 is running
# MySQL server from group: mysqld33062 is running
# MySQL server from group: mysqld33063 is running
# MySQL server from group: mysqld33064 is running
```

```
# 查看相应端口是否已经被监听
netstat -tunlp

# 查看是否有活动进程
ps -aux|grep mysql
```

## 登录数据库

```
# 进入端口为3306的数据库
mysql -uroot -p -h127.0.0.1 -P3306

# 通过sock文件登录
mysql -uroot -p -S /usr/local/var/mysql1/mysql1.sock

# 查看socket文件
mysql> SHOW VARIABLES LIKE 'socket';

# 查看pid文件
mysql> SHOW VARIABLES LIKE '%pid%';
```

## 创建测试数据库

```
mysql -uroot -proot -h127.0.0.1 -P33061 -e "CREATE DATABASE IF NOT EXISTS test;"
mysql -uroot -proot -h127.0.0.1 -P33062 -e "CREATE DATABASE IF NOT EXISTS test;"
mysql -uroot -proot -h127.0.0.1 -P33063 -e "CREATE DATABASE IF NOT EXISTS test;"
mysql -uroot -proot -h127.0.0.1 -P33064 -e "CREATE DATABASE IF NOT EXISTS test;"

mysql -uroot -proot -h127.0.0.1 -P33061 -e "CREATE USER mysql_replicant@localhost; GRANT ALL ON *.* TO mysql_replicant@localhost WITH GRANT OPTION;"
mysql -uroot -proot -h127.0.0.1 -P33062 -e "CREATE USER mysql_replicant@localhost; GRANT ALL ON *.* TO mysql_replicant@localhost WITH GRANT OPTION;"
mysql -uroot -proot -h127.0.0.1 -P33063 -e "CREATE USER mysql_replicant@localhost; GRANT ALL ON *.* TO mysql_replicant@localhost WITH GRANT OPTION;"
mysql -uroot -proot -h127.0.0.1 -P33064 -e "CREATE USER mysql_replicant@localhost; GRANT ALL ON *.* TO mysql_replicant@localhost WITH GRANT OPTION;"
```

