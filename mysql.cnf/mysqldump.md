# mysqldump

## mysqldump的几种常用方法：

* 导出整个数据库(包括数据库中的数据）

```sh
mysqldump -u username -p dbname > dbname.sql
```

* 导出数据库结构（不含数据）

```sh
mysqldump -u username -p -d dbname > dbname.sql
```

* 导出数据库中的某张数据表（包含数据）

```sh
mysqldump -u username -p dbname tablename > tablename.sql
```

* 导出数据库中的某张数据表的表结构（不含数据）

```sh
mysqldump -u username -p -d dbname tablename > tablename.sql
```

## mysqldump常用参数说明：

* –all-databases , -A 导出全部数据库mysqldump -uroot -p –all-databases
* –all-tablespaces , -Y导出全部表空间。mysqldump -uroot -p –all-databases –all-tablespaces–no-tablespaces , -y不导出任何表空间信息。mysqldump -uroot -p –all-databases –no-tablespaces
* –add-drop-database每个数据库创建之前添加drop数据库语句。mysqldump -uroot -p –all-databases –add-drop-database
* –add-drop-table每个数据表创建之前添加drop数据表语句。(默认为打开状态，使用–skip-add-drop-table取消选项)mysqldump -uroot -p –all-databases (默认添加drop语句)mysqldump -uroot -p –all-databases * –skip-add-drop-table (取消drop语句)
* –add-locks在每个表导出之前增加LOCK TABLES并且之后UNLOCK TABLE。(默认为打开状态，使用–skip-add-locks取消选项)mysqldump -uroot -p –all-databases (默认添加LOCK语句)mysqldump -uroot -p –all-databases * –skip-add-locks (取消LOCK语句)
* –comments附加注释信息。默认为打开，可以用–skip-comments取消mysqldump -uroot -p –all-databases (默认记录注释)mysqldump -uroot -p –all-databases –skip-comments (取消注释)
* –compact导出更少的输出信息(用于调试)。去掉注释和头尾等结构。可以使用选项：–skip-add-drop-table –skip-add-locks –skip-comments –skip-disable-keysmysqldump -uroot -p –all-databases –compact
* –complete-insert, -c使用完整的insert语句(包含列名称)。这么做能提高插入效率，但是可能会受到max_allowed_packet参数的影响而导致插入失败。mysqldump -uroot -p –all-databases –complete-insert
* –compress, -C在客户端和服务器之间启用压缩传递所有信息mysqldump -uroot -p –all-databases –compress
* –databases, -B导出几个数据库。参数后面所有名字参量都被看作数据库名。mysqldump -uroot -p –databases test mysql
* –debug输出debug信息，用于调试。默认值为：d:t:o,/tmp/mysqldump.tracemysqldump -uroot -p –all-databases –debugmysqldump -uroot -p –all-databases –debug=” d:t:o,/tmp/debug.trace”
* –debug-info输出调试信息并退出mysqldump -uroot -p –all-databases –debug-info
* –default-character-set设置默认字符集，默认值为utf8mysqldump -uroot -p –all-databases –default-character-set=latin1
* –delayed-insert采用延时插入方式（INSERT DELAYED）导出数据mysqldump -uroot -p –all-databases –delayed-insert
* –events, -E导出事件。mysqldump -uroot -p –all-databases –events
* –flush-logs开始导出之前刷新日志。请注意：假如一次导出多个数据库(使用选项–databases或者–all-databases)，将会逐个数据库刷新日志。除使用–lock-all-tables或者–master-data外。在这种情况下，日志将会被刷新一次，相应* 的所以表同时被锁定。因此，如果打算同时导出和刷新日志应该使用–lock-all-tables 或者–master-data 和–flush-logs。mysqldump -uroot -p –all-databases –flush-logs
* –flush-privileges在导出mysql数据库之后，发出一条FLUSH PRIVILEGES 语句。为了正确恢复，该选项应该用于导出mysql数据库和依赖mysql数据库数据的任何时候。mysqldump -uroot -p –all-databases –flush-privileges
* –force在导出过程中忽略出现的SQL错误。mysqldump -uroot -p –all-databases –force
* –host, -h需要导出的主机信息mysqldump -uroot -p –host=localhost –all-databases
* –ignore-table不导出指定表。指定忽略多个表时，需要重复多次，每次一个表。每个表必须同时指定数据库和表名。例如：–ignore-table=database.table1 –ignore-table=database.table2 ……mysqldump -uroot -p * –host=localhost –all-databases –ignore-table=mysql.user
* –lock-all-tables, -x提交请求锁定所有数据库中的所有表，以保证数据的一致性。这是一个全局读锁，并且自动关闭–single-transaction 和–lock-tables 选项。mysqldump -uroot -p –host=localhost –all-databases * –lock-all-tables
* –lock-tables, -l开始导出前，锁定所有表。用READ LOCAL锁定表以允许MyISAM表并行插入。对于支持事务的表例如InnoDB和BDB，–single-transaction是一个更好的选择，因为它根本不需要锁定表。请注意当导出多个数据库时，* –lock-tables分别为每个数据库锁定表。因此，该选项不能保证导出文件中的表在数据库之间的逻辑一致性。不同数据库表的导出状态可以完全不同。mysqldump -uroot -p –host=localhost –all-databases –lock-tables
* –no-create-db, -n只导出数据，而不添加CREATE DATABASE 语句。mysqldump -uroot -p –host=localhost –all-databases –no-create-db
* –no-create-info, -t只导出数据，而不添加CREATE TABLE 语句。mysqldump -uroot -p –host=localhost –all-databases –no-create-info
* –no-data, -d不导出任何数据，只导出数据库表结构。mysqldump -uroot -p –host=localhost –all-databases –no-data
* –password, -p连接数据库密码
* –port, -P连接数据库端口号
* –user, -u指定连接的用户名。

## mysqldump常用实例：

mysqldump常用于数据库的备份与还原，在备份的过程中我们可以根据自己的实际情况添加以上任何参数，假设有数据库test_db，执行以下命令，即可完成对整个数据库的备份：

```sh
mysqldump -u root -p test_db > test_db.sql
```

如要对数据进行还原，可执行如下命令：

```sh
mysql -u username -p test_db < test_db.sql
```

还原数据库操作还可以使用以下方法：

```sh
mysql> source test_db.sql
```

直接将MySQL数据库压缩备份

```sh
mysqldump -hhostname -uusername -ppassword databasename | gzip > backupfile.sql.gz
```

备份MySQL数据库某个(些)表

```sh
mysqldump -hhostname -uusername -ppassword databasename specific_table1 specific_table2 > backupfile.sql
```

同时备份多个MySQL数据库

```sh
mysqldump -hhostname -uusername -ppassword –databases databasename1 databasename2 databasename3 > multibackupfile.sql
```

仅仅备份数据库结构

```sh
mysqldump –no-data –databases databasename1 databasename2 databasename3 > structurebackupfile.sql
```

还原MySQL数据库的命令

```sh
mysql -hhostname -uusername -ppassword databasename < backupfile.sql
```

还原压缩的MySQL数据库

```sh
gunzip < backupfile.sql.gz | mysql -uusername -ppassword databasename
```

将数据库转移到新服务器

```sh
mysqldump -uusername -ppassword databasename | mysql –host=*.*.*.* -C databasename
```

