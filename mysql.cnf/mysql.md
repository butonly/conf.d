
# 数据定义语言DDL：CREATE DROP ALTER
# 数据操作语言DML：INSERT UPDATE DELETE
# 数据查询语言DQL：SELECT
# 数据控制语言DCL：GRANT REVOKE COMMIT ROLLBACK

SHOW DATABASES;
CREATE DATABASE database_name;
DROP DATABASE database_name;
SHOW CREATE DATABASE database_name\G;

SHOW ENGINES\G;

备份MySQL数据库的命令

mysqldump -hhostname -uusername -ppassword databasename > backupfile.sql

备份MySQL数据库为带删除表的格式

备份MySQL数据库为带删除表的格式，能够让该备份覆盖已有数据库而不需要手动删除原有数据库。

mysqldump -–add-drop-table -uusername -ppassword databasename > backupfile.sql

直接将MySQL数据库压缩备份

mysqldump -hhostname -uusername -ppassword databasename | gzip > backupfile.sql.gz

备份MySQL数据库某个(些)表

mysqldump -hhostname -uusername -ppassword databasename specific_table1 specific_table2 > backupfile.sql

同时备份多个MySQL数据库

mysqldump -hhostname -uusername -ppassword –databases databasename1 databasename2 databasename3 > multibackupfile.sql

仅仅备份数据库结构

mysqldump –no-data –databases databasename1 databasename2 databasename3 > structurebackupfile.sql

备份服务器上所有数据库

mysqldump –all-databases > allbackupfile.sql

还原MySQL数据库的命令

mysql -hhostname -uusername -ppassword databasename < backupfile.sql

还原压缩的MySQL数据库

gunzip < backupfile.sql.gz | mysql -uusername -ppassword databasename

将数据库转移到新服务器

mysqldump -uusername -ppassword databasename | mysql –host=*.*.*.* -C databasename

mysql TIMESTAMP（时间戳）详解

TIMESTAMP的变体
1，TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
在创建新记录和修改现有记录的时候都对这个数据列刷新

2，TIMESTAMP DEFAULT CURRENT_TIMESTAMP  在创建新记录的时候把这个
字段设置为当前时间，但以后修改时，不再刷新它

3，TIMESTAMP ON UPDATE CURRENT_TIMESTAMP  在创建新记录的时候把这个字段设置为0，
以后修改时刷新它  www.2cto.com

4，TIMESTAMP DEFAULT ‘yyyy-mm-dd hh:mm:ss’ ON UPDATE CURRENT_TIMESTAMP
在创建新记录的时候把这个字段设置为给定值，以后修改时刷新它
MySQL目前不支持列的Default 为函数的形式,如达到你某列的默认值为当前更新日期
与时间的功能,你可以使用TIMESTAMP列类型下面就详细说明TIMESTAMP列类型

*TIMESTAMP列类型*
TIMESTAMP值可以从1970的某时的开始一直到2037年，精度为一秒，其值作为数字显示。
TIMESTAMP值显示尺寸的格式如下表所示：
：
+---------------+----------------+
| 列类型　　　　| 显示格式　　　 |
| TIMESTAMP(14) | YYYYMMDDHHMMSS |　
| TIMESTAMP(12) | YYMMDDHHMMSS　 |
| TIMESTAMP(10) | YYMMDDHHMM　　 |
| TIMESTAMP(8)　| YYYYMMDD　　　 |
| TIMESTAMP(6)　| YYMMDD　　　　 |
| TIMESTAMP(4)　| YYMM　　　　　 |
| TIMESTAMP(2)　| YY　　　　　　 |
+---------------+----------------+
“完整”TIMESTAMP格式是14位，但TIMESTAMP列也可以用更短的显示尺寸
创造最常见的显示尺寸是6、8、12、和14。
你可以在创建表时指定一个任意的显示尺寸，但是定义列长为0或比14大均会被强制定义为列长14。
列长在从1～13范围的奇数值尺寸均被强制为下一个更大的偶数。

*列如：*
定义字段长度　　 强制字段长度
TIMESTAMP(0) ->　TIMESTAMP(14)
TIMESTAMP(15)->　TIMESTAMP(14)
TIMESTAMP(1) ->　TIMESTAMP(2)
TIMESTAMP(5) ->　TIMESTAMP(6)

所有的TIMESTAMP列都有同样的存储大小，使用被指定的时期时间值的完整精度
（14位）存储合法的值不考虑显示尺寸。不合法的日期，将会被强制为0存储
*这有几个含意： *  www.2cto.com
1、虽然你建表时定义了列TIMESTAMP(8)，但在你进行数据插入与更新时TIMESTAMP列
实际上保存了14位的数据（包括年月日时分秒），只不过在你进行查询时MySQL返回给
你的是8位的年月日数据。如果你使用ALTER TABLE拓宽一个狭窄的TIMESTAMP列，
以前被“隐蔽”的信息将被显示。
2、同样，缩小一个TIMESTAMP列不会导致信息失去，除了感觉上值在显示时，
较少的信息被显示出。
3、尽管TIMESTAMP值被存储为完整精度，直接操作存储值的唯一函数是UNIX_TIMESTAMP()；
由于MySQL返回TIMESTAMP列的列值是进过格式化后的检索的值，这意味着你可能不能使用某些函数来操作TIMESTAMP列（例如HOUR()或SECOND()），除非TIMESTAMP值的相关部分被包含在格式化的值中。
例如，一个TIMESTAMP列只有被定义为TIMESTAMP(10)以上时，TIMESTAMP列的HH部分才会被显示，
因此在更短的TIMESTAMP值上使用HOUR()会产生一个不可预知的结果。
4、不合法TIMESTAMP值被变换到适当类型的“零”值(00000000000000)。（DATETIME,DATE亦然）
*你可以使用下列语句来验证：*
CREATE TABLE test ('id' INT (3) UNSIGNED AUTO_INCREMENT, 'date1'
TIMESTAMP (8) PRIMARY KEY('id'));
INSERT INTO test SET id = 1;
SELECT * FROM test;
+----+----------------+
| id | date1　　　　　|
+----+----------------+
|　1 | 20021114　　　 |
+----+----------------+
ALTER TABLE test CHANGE 'date1' 'date1' TIMESTAMP(14);
SELECT * FROM test;
+----+----------------+
| id | date1　　　　　|
+----+----------------+
|　1 | 20021114093723 |
+----+----------------+

你可以使用TIMESTAMP列类型自动地用当前的日期和时间标记INSERT或UPDATE的操作。
如果你有多个TIMESTAMP列，只有第一个自动更新。自动更新第一个TIMESTAMP列在下列任何条件下发生：
1、列值没有明确地在一个INSERT或LOAD DATA INFILE语句中指定。
2、列值没有明确地在一个UPDATE语句中指定且另外一些的列改变值。（注意一个UPDATE
设置一个列为它已经有的值，这将不引起TIMESTAMP列被更新，因为如果你设置一个列为
它当前的值，MySQL为了效率而忽略更改。）
3、你明确地设定TIMESTAMP列为NULL.
4、除第一个以外的TIMESTAMP列也可以设置到当前的日期和时间，只要将列设为NULL，或NOW()。
CREATE TABLE test (  www.2cto.com
'id' INT (3) UNSIGNED AUTO_INCREMENT,
'date1' TIMESTAMP (14),
'date2' TIMESTAMP (14),
PRIMARY KEY('id')
);

INSERT INTO test (id, date1, date2) VALUES (1, NULL, NULL);
INSERT INTO test SET id= 2;
+----+----------------+----------------+
| id | date1　　　　　| date2　　　　　|
+----+----------------+----------------+
|　1 | 20021114093723 | 20021114093723 |
|　2 | 20021114093724 | 00000000000000 |
+----+----------------+----------------+
->第一条指令因设date1、date2为NULL,所以date1、date2值均为当前时间第二条指令
因没有设date1、date2列值，第一个TIMESTAMP列date1为更新为当前时间，
而二个TIMESTAMP列date2因日期不合法而变为“00000000000000”
UPDATE test SET id= 3 WHERE id=1;
+----+----------------+----------------+
| id | date1　　　　　| date2　　　　　|
+----+----------------+----------------+
|　3 | 20021114094009 | 20021114093723 |
|　2 | 20021114093724 | 00000000000000 |
+----+----------------+----------------+
->这条指令没有明确地设定date2的列值，所以第一个TIMESTAMP列date1将被更新为当前时间

UPDATE test SET id= 1,date1=date1,date2=NOW() WHERE id=3;  www.2cto.com
+----+----------------+----------------+
| id | date1　　　　　| date2　　　　　|
+----+----------------+----------------+
|　1 | 20021114094009 | 20021114094320 |
|　2 | 20021114093724 | 00000000000000 |
+----+----------------+----------------+
->这条指令因设定date1=date1，所以在更新数据时date1列值并不会发生改变而
因设定date2=NOW()，所以在更新数据时date2列值会被更新为当前时间此指令等效为
UPDATE test SET id= 1,date1=date1,date2=NULL WHERE id=3;
因MySQL返回的 TIMESTAMP 列为数字显示形式，你可以用DATE_FROMAT()函数来格式化 TIMESTAMP 列
SELECT id,DATE_FORMAT(date1,'%Y-%m-%d %H:%i:%s') As date1,
DATE_FORMAT(date2,'%Y-%m-%d %H:%i:%s') As date2 FROM test;
+----+---------------------+---------------------+
| id | date1　　　　　　　 | date2　　　　　　　 |
+----+---------------------+---------------------+
|　1 | 2002-11-14 09:40:09 | 2002-11-14 09:43:20 |
|　2 | 2002-11-14 09:37:24 | 0000-00-00 00:00:00 |
+----+---------------------+---------------------+

SELECT id,DATE_FORMAT(date1,'%Y-%m-%d') As date1,
DATE_FORMAT(date2,'%Y-%m-%d') As date2 FROM test;
  www.2cto.com
+----+-------------+-------------+
| id | date1　　　 | date2　　　 |
+----+-------------+-------------+
|　1 | 2002-11-14　| 2002-11-14　|
|　2 | 2002-11-14　| 0000-00-00　|
+----+-------------+-------------+

在某种程度上，你可以把一种日期类型的值赋给一个不同的日期类型的对象。
然而，而尤其注意的是：值有可能发生一些改变或信息的损失：

1、如果你将一个DATE值赋给一个DATETIME或TIMESTAMP对象，结果值的时间部分被
设置为'00:00:00'，因为DATE值中不包含有时间信息。　　
2、如果你将一个DATETIME或TIMESTAMP值赋给一个DATE对象，结果值的时间部分被删除，
因为DATE类型不存储时间信息。
3、尽管DATETIME, DATE和TIMESTAMP值全都可以用同样的格式集来指定，
但所有类型不都有同样的值范围。
例如，TIMESTAMP值不能比1970早，也不能比2037晚，这意味着，一个日期例如'1968-01-01'，
当作为一个DATETIME或DATE值时它是合法的，但它不是一个正确TIMESTAMP值！
并且如果将这样的一个对象赋值给TIMESTAMP列，它将被变换为0。  www.2cto.com

*当指定日期值时，当心某些缺陷： *

1、允许作为字符串指定值的宽松格式能被欺骗。例如，，因为“:”分隔符的使用，
值'10:11:12'可能看起来像时间值，但是如果在一个日期中使用，上下文将作为年份被
解释成'2010-11-12'。值'10:45:15'将被变换到'0000-00-00'，因为'45'不是一个合法的月份。

2、以2位数字指定的年值是模糊的，因为世纪是未知的。MySQL使用下列规则解释2位年值：
在00-69范围的年值被变换到2000-2069。 在范围70-99的年值被变换到1970-1999。


类型		字节数		长度		范围

TINYINT 	1 Byte		0-3			[0, 255]
SMALLINT	2 Byte		0-5			[-2^15 (-32768), 2^15–1 (32767)]
INT 		4 Byte		0-11		[-2^31 (-2147483648), 2^31–1 (2147483647)]
BIGINT		8 Byte		0-10		[-2^63 (-9223372036854775808), 2^63-1 (9223372036854775807)]

1．索引作用

   在索引列上，除了上面提到的有序查找之外，数据库利用各种各样的快速定位技术，能够大大提高查询效率。特别是当数据量非常大，查询涉及多个表时，使用索引往往能使查询速度加快成千上万倍。

   例如，有3个未索引的表t1、t2、t3，分别只包含列c1、c2、c3，每个表分别含有1000行数据组成，指为1～1000的数值，查找对应值相等行的查询如下所示。

SELECT c1,c2,c3 FROM t1,t2,t3 WHERE c1=c2 AND c1=c3

   此查询结果应该为1000行，每行包含3个相等的值。在无索引的情况下处理此查询，必须寻找3个表所有的组合，以便得出与WHERE子句相配的那些行。而可能的组合数目为1000×1000×1000（十亿），显然查询将会非常慢。

   如果对每个表进行索引，就能极大地加速查询进程。利用索引的查询处理如下。

（1）从表t1中选择第一行，查看此行所包含的数据。

（2）使用表t2上的索引，直接定位t2中与t1的值匹配的行。类似，利用表t3上的索引，直接定位t3中与来自t1的值匹配的行。

（3）扫描表t1的下一行并重复前面的过程，直到遍历t1中所有的行。

   在此情形下，仍然对表t1执行了一个完全扫描，但能够在表t2和t3上进行索引查找直接取出这些表中的行，比未用索引时要快一百万倍。

   利用索引，MySQL加速了WHERE子句满足条件行的搜索，而在多表连接查询时，在执行连接时加快了与其他表中的行匹配的速度。

2.  创建索引

在执行CREATE TABLE语句时可以创建索引，也可以单独用CREATE INDEX或ALTER TABLE来为表增加索引。

1．ALTER TABLE

ALTER TABLE用来创建普通索引、UNIQUE索引或PRIMARY KEY索引。



ALTER TABLE table_name ADD INDEX index_name (column_list)

ALTER TABLE table_name ADD UNIQUE (column_list)

ALTER TABLE table_name ADD PRIMARY KEY (column_list)



其中table_name是要增加索引的表名，column_list指出对哪些列进行索引，多列时各列之间用逗号分隔。索引名index_name可选，缺省时，MySQL将根据第一个索引列赋一个名称。另外，ALTER TABLE允许在单个语句中更改多个表，因此可以在同时创建多个索引。

2．CREATE INDEX

CREATE INDEX可对表增加普通索引或UNIQUE索引。



CREATE INDEX index_name ON table_name (column_list)

CREATE UNIQUE INDEX index_name ON table_name (column_list)



table_name、index_name和column_list具有与ALTER TABLE语句中相同的含义，索引名不可选。另外，不能用CREATE INDEX语句创建PRIMARY KEY索引。

3．索引类型

在创建索引时，可以规定索引能否包含重复值。如果不包含，则索引应该创建为PRIMARY KEY或UNIQUE索引。对于单列惟一性索引，这保证单列不包含重复的值。对于多列惟一性索引，保证多个值的组合不重复。

PRIMARY KEY索引和UNIQUE索引非常类似。事实上，PRIMARY KEY索引仅是一个具有名称PRIMARY的UNIQUE索引。这表示一个表只能包含一个PRIMARY KEY，因为一个表中不可能具有两个同名的索引。

下面的SQL语句对students表在sid上添加PRIMARY KEY索引。



ALTER TABLE students ADD PRIMARY KEY (sid)

4.  删除索引

可利用ALTER TABLE或DROP INDEX语句来删除索引。类似于CREATE INDEX语句，DROP INDEX可以在ALTER TABLE内部作为一条语句处理，语法如下。



DROP INDEX index_name ON talbe_name

ALTER TABLE table_name DROP INDEX index_name

ALTER TABLE table_name DROP PRIMARY KEY



其中，前两条语句是等价的，删除掉table_name中的索引index_name。

第3条语句只在删除PRIMARY KEY索引时使用，因为一个表只可能有一个PRIMARY KEY索引，因此不需要指定索引名。如果没有创建PRIMARY KEY索引，但表具有一个或多个UNIQUE索引，则MySQL将删除第一个UNIQUE索引。

如果从表中删除了某列，则索引会受到影响。对于多列组合的索引，如果删除其中的某列，则该列也会从索引中删除。如果删除组成索引的所有列，则整个索引将被删除。

5．查看索引

mysql> show index from tblname;

mysql> show keys from tblname;

　　· Table

　　表的名称。

　　· Non_unique

　　如果索引不能包括重复词，则为0。如果可以，则为1。

　　· Key_name

　　索引的名称。

　　· Seq_in_index

　　索引中的列序列号，从1开始。

　　· Column_name

　　列名称。

　　· Collation

　　列以什么方式存储在索引中。在MySQL中，有值‘A’（升序）或NULL（无分类）。

　　· Cardinality

　　索引中唯一值的数目的估计值。通过运行ANALYZE TABLE或myisamchk -a可以更新。基数根据被存储为整数的统计数据来计数，所以即使对于小型表，该值也没有必要是精确的。基数越大，当进行联合时，MySQL使用该索引的机会就越大。

　　· Sub_part

　　如果列只是被部分地编入索引，则为被编入索引的字符的数目。如果整列被编入索引，则为NULL。

　　· Packed

　　指示关键字如何被压缩。如果没有被压缩，则为NULL。

　　· Null

　　如果列含有NULL，则含有YES。如果没有，则该列含有NO。

　　· Index_type

　　用过的索引方法（BTREE, FULLTEXT, HASH, RTREE）。

　　· Comment

GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY 'root' WITH GRANT OPTION;
FLUSH privileges;

CREATE USER 'dbmanager' IDENTIFIED BY 'dbmanager'
GRANT ALL PRIVILEGES ON db.* TO 'dbmanager'@'localhost' IDENTIFIED BY 'dbmanager';
GRANT ALL PRIVILEGES ON db.* TO 'dbmanager'@'localhost' IDENTIFIED BY 'dbmanager';
FLUSH privileges;

CREATE USER user_specification [, user_specification] ...

user_specification:
    user [ identified_option ]

auth_option: {
    IDENTIFIED BY 'auth_string'
  | IDENTIFIED BY PASSWORD 'hash_string'
  | IDENTIFIED WITH auth_plugin
  | IDENTIFIED WITH auth_plugin AS 'hash_string'
}

CREATE USER 'jeffrey'@'localhost' IDENTIFIED BY 'mypass';
CREATE USER 'jeffrey'@'localhost' IDENTIFIED WITH mysql_native_password;

CREATE USER 'jeffrey'@'localhost' IDENTIFIED WITH mysql_native_password;
SET old_passwords = 0;
SET PASSWORD FOR 'jeffrey'@'localhost' = PASSWORD('mypass');

SET PASSWORD [FOR user] = password_option

password_option: {
    PASSWORD('auth_string')
  | OLD_PASSWORD('auth_string')
  | 'hash_string'
}

DROP USER user [, user] ...

DROP USER 'jeffrey'@'localhost';

RENAME USER old_user TO new_user
    [, old_user TO new_user] ...

RENAME USER 'jeffrey'@'localhost' TO 'jeff'@'127.0.0.1';

REVOKE
    priv_type [(column_list)]
      [, priv_type [(column_list)]] ...
    ON [object_type] priv_level
    FROM user [, user] ...

GRANT priv_type [(column_list)] [, priv_type [(column_list)]] ...
ON [object_type] priv_level
TO user_specification [, user_specification] ...
[REQUIRE {NONE | tsl_option [[AND] tsl_option] ...}]
[WITH {GRANT OPTION | resource_option} ...]

GRANT PROXY ON user_specification
    TO user_specification [, user_specification] ...
    [WITH GRANT OPTION]

object_type: {
    TABLE
  | FUNCTION
  | PROCEDURE
}

priv_level: {
    *
  | *.*
  | db_name.*
  | db_name.tbl_name
  | tbl_name
  | db_name.routine_name
}

user_specification:
    user [ auth_option ]

auth_option: {
    IDENTIFIED BY 'auth_string'
  | IDENTIFIED BY PASSWORD 'hash_string'
  | IDENTIFIED WITH auth_plugin
  | IDENTIFIED WITH auth_plugin AS 'hash_string'
}

tsl_option: {
    SSL
  | X509
  | CIPHER 'cipher'
  | ISSUER 'issuer'
  | SUBJECT 'subject'
}

resource_option: {
  | MAX_QUERIES_PER_HOUR count
  | MAX_UPDATES_PER_HOUR count
  | MAX_CONNECTIONS_PER_HOUR count
  | MAX_USER_CONNECTIONS count
}

REVOKE ALL PRIVILEGES, GRANT OPTION FROM user [, user] ...

REVOKE PROXY ON user FROM user [, user] ...

CREATE USER 'jeffrey'@'localhost' IDENTIFIED BY 'mypass';
GRANT ALL ON db1.* TO 'jeffrey'@'localhost';
GRANT SELECT ON db2.invoice TO 'jeffrey'@'localhost';
GRANT USAGE ON *.* TO 'jeffrey'@'localhost' WITH MAX_QUERIES_PER_HOUR 90;

PRIVILEGES : SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,INDEX,ALTER,GRANT,REFERENCES,RELOAD,SHUTDOWN,PROCESS,FILE

