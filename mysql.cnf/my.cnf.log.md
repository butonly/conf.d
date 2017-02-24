### 日志分类：错误日志 查询日志 慢查询日志 二进制日志 中继日志 事务日志 滚动日志
#原创作品，允许转载，转载时请务必以超链接形式标明文章 原始出处 、作者信息和本声明。否则将追究法律责任。http://freeloda.blog.51cto.com/2033581/1253991

### 错误日志
说明：在对应的数据目录中，以主机名+.err命名的文件
错误日志记录的信息类型：
	记录了服务器运行中产生的错误信息
	记录了服务在启动和停止是所产生的信息
	在从服务器上如果启动了复制进程的时候，复制进程的信息也会被记录
	记录event错误日志

log_error = /mydata/data/mysql.test.com.err #指定错误日志的位置，默认是在数据目录下，这个位置mysql用户必须有写权限
log_warning = {0|1} 						#默认开启，服务器运行中的警告日志也会记录在错误日志中

### 查询日志
说明：对除了慢查日志中记录的查询信息都将记录下来,这将对服务器主机产生大量的压力，所以对于繁忙的服务器应该关闭这个日志
log = {ON|OFF} 								#是否启用查询日志，该指令在mysq5.6中已废弃
general_log = {ON|OFF} 						#启动或关闭查询日志，默认是关闭的
general_log_file = /mydata/data/mysql.log 	#指定查询日志的位置，默认在数据目录下
log_output = {TABLE|FILE|NONE} 				#指定存放查询日志的位置，可以放在文件中，也可以放在数据库的表中，放在表中比放在文件中更容易查看

### 慢查询日志
说明：默认为关闭状态，记录下来查询时间超过设定时长的查询，这些查询日志将被慢查日志记录下来
slow_query_log  = {ON | OFF} 						#是否开启慢慢查询日志，默认是关闭的
slow_query_log_file = /mydata/data/mysql-slow.log 	#慢查询日志的存放位置，默认在数据目录下
log_query_time = 10 								#定义默认的时长，默认时长为10秒
log_query_not_using_indexes = {ON|OFF} 				#设定是否将没有使用索引的查询操作记录到慢查询日志
log_output = {TABLE|FILE|NONE} 						#定义一般查询日志和慢查询日志的保存方式，可以是TABLE、FILE、NONE，也可以是TABLE及FILE的组合(用逗号隔开)，默认为FILE。如果组合中出现了NONE，那么其它设定都将失效，同时，无论是否启用日志功能，也不会记录任何相关的日志信息

### 二进制日志
说明：默认开启，精确的记录了用户对数据库中的数据进行操作的命令和操作的数据对象。
#### 二进制日志文件的作用：
	提供了增量备份的功能
	提供了数据基于时间点的恢复，这个恢复的时间点可以由用户控制
	为mysql的复制架构提供基础，将这主服务器的二进制日志复制到从服务器上并执行同样的操作，就可将数据进行同步
#### 二进制日志格式：
	基于语句 statement
	基于行 row
	混合方式 mixed
#### 二进制日志事件：
	position 基于位置
	datetime 基于时间
#### 二进制日志的查看与删除方式：
	mysql>show master status; 查看当前正在使用的二进制日志
	mysql>show binlog events in 'mysql-bin.000001'; 查看二进制日志记录的事件[from position]
	mysql>flush logs; 二进制日志滚动
	mysql>show binary logs; 查看所有二进制日志
	mysql>purge binary logs to 'mysql-bin.000003'; 删除二进制日志
#### 文件系统中查看二进制日志的命令：
    mysqlbinlog --start-position --stop-position --start-datetime 'yyyy-mm-dd hh:mm:ss' --stop-datetime 'yyyy-mm-dd hh:mm:ss'
    mysqlbinlog --start-position 0 --stop-position 100
#### 注：一般建议将binlog日志与数据文件分开存放，不但可以提高mysql性能，还可以增加安全性！
sql_log_bin = {ON|OFF}                  #用于控制二进制日志信息是否记录进日志文件。默认为ON，表示启用记录功能。用户可以在会话级别修改此变量的值，但其必须具有SUPER权限
binlog_cache_size = 32768               #默认值32768 Binlog Cache 用于在打开了二进制日志（binlog）记录功能的环境，是 MySQL 用来提高binlog的记录效率而设计的一个用于短时间内临时缓存binlog数据的内存区域。一般来说，如果我们的数据库中没有什么大事务，写入也不是特别频繁，2MB～4MB是一个合适的选择。但是如果我们的数据库大事务较多，写入量比较大，可与适当调高binlog_cache_size。同时，我们可以通过binlog_cache_use 以及 binlog_cache_disk_use来分析设置的binlog_cache_size是否足够，是否有大量的binlog_cache由于内存大小不够而使用临时文件（binlog_cache_disk_use）来缓存了
binlog_stmt_cache_size = 32768          #当非事务语句使用二进制日志缓存，但是超出binlog_stmt_cache_size时，使用一个临时文件来存放这些语句
log_bin = mysql-bin                     #指定binlog的位置，默认在数据目录下
binlog-format = {ROW|STATEMENT|MIXED}   #指定二进制日志的类型，默认为MIXED。如果设定了二进制日志的格式，却没有启用二进制日志，则MySQL启动时会产生警告日志信息并记录于错误日志中。
sync_binlog = 10                        #设定多久同步一次二进制日志至磁盘文件中，0表示不同步，任何正数值都表示对二进制每多少次写操作之后同步一次。当autocommit的值为1时，每条语句的执行都会引起二进制日志同步，否则，每个事务的提交会引起二进制日志同步
max_binlog_cache_size = {4096 .. 18446744073709547520}      #二进定日志缓存空间大小，5.5.9及以后的版本仅应用于事务缓存，其上限由max_binlog_stmt_cache_size决定。
max_binlog_stmt_cache_size = {4096 .. 18446744073709547520} #二进定日志缓存空间大小，5.5.9及以后的版本仅应用于事务缓存
expire_log_days = {0..99}               #设定二进制日志的过期天数，超出此天数的二进制日志文件将被自动删除。默认为0，表示不启用过期自动删除功能。如果启用此功能，自动删除工作通常发生在MySQL启动时或FLUSH日志时

### 中继日志
说明：主要是在mysql服务器的主从架构中的从服务器上用到的，
当从服务器想要和主服务器进行数据的同步时，
从服务器将主服务器的二进制日志文件拷贝到己的主机上放在中继日志中，
然后调用SQL线程按照拷中继日志文件中的二进制日志文件执行以便就可达到数据的同步
开启的方法：（只在从服务器上开启）
relay-log = file_name #指定中继日志的位置和名字，默认为host_name-relay-bin。也可以使用绝对路径，以指定非数据目录来存储中继日志
relay-log-index = file_name #指定中继日志的名字的索引文件的位置和名字，默认为数据目录中的host_name-relay-bin.index
relay-log-info-file = file_name #设定中继服务用于记录中继信息的文件，默认为数据目录中的relay-log.info
relay_log_purge = {ON|OFF} #设定对不再需要的中继日志是否自动进行清理。默认值为ON
relay_log_space_limit = 0 #设定用于存储所有中继日志文件的可用空间大小。默认为0，表示不限定。最大值取决于系统平台位数
max_relay_log_size = {4096..1073741824} #设定从服务器上中继日志的体积上限，到达此限度时其会自动进行中继日志滚动。此参数值为0时，mysqld将使用max_binlog_size参数同时为二进制日志和中继日志设定日志文件体积上限

### 事务日志
说明：详细的记录了在什么时间发生了什么时候，在哪个时间对哪些数据进行了改变，能后实现事件的重放，一般只记录对数据进行改变的操作，对于读操作一般不进行记录。
#### 事物日志为数据库服务器实现以下功能：
(1).将随机IO转换为顺序IO，大大的提高了数据库的性能，存储的数据可能存在在磁盘的不同位置，降低了数据的读取和操作性能。转换为顺序IO的原理为，先将数据存放在日志文件中，然后由RDBSM的后台将日志中的数据存放到磁盘上，这样就保证了存储的数据是连续的。
(2).为事件重放提供基础，事务日志详细的记录了时间发生的时间以及操作的数据对象，事务进程可以根据这些信息进行时间重放。
默认的事务日志文件有两个，位于数据目录下以ibdata+number结尾的数字，我们可以对事务日志的位置、文件大小、增长方式进行定义，定义的方法如下：
这里以使用支持事务的Innodb存储引擎为例，
innodb_data_home_dir = /mydata/data  #InnoDB所有共享表空间数据文件的目录路径，默认在数据目录下
innodb_data_file_path = ibdata1:1024M  #指定InnoDB的各个数据文件及其大小，文件多于一个时彼此间用分号隔开
innodb_data_file_path = ibdata2:50M:autoextend  #定义数据大小的增长方式
innodb_log_group_home_dir = /mydata/data #设定InnoDB重要日志文件的存储目录。在缺省使用InnoDB日志相关的所有变量时，其默认会在数据目录中创建两个大小为5MB的名为ib_logfile0和ib_logfile1的日志文件
innodb_log_files_in_group = {2 .. 100} #设定日志组中日志文件的个数。InnoDB以循环的方式使用这些日志文件。默认值为2
innodb_log_file_size = {108576 .. 4294967295} #设定日志组中每个日志文件的大小，单位是字节，默认值是5MB。较为明智的取值范围是从1MB到缓存池体积的1/n，其中n表示日志组中日志文件的个数。日志文件越大，在缓存池中需要执行的检查点刷写操作就越少，这意味着所需的I/O操作也就越少，然而这也会导致较慢的故障恢复速度
innodb_log_buffer_size = {262144 .. 4294967295} #设定InnoDB用于辅助完成日志文件写操作的日志缓冲区大小，单位是字节，默认为8MB。较大的事务可以借助于更大的日志缓冲区来避免在事务完成之前将日志缓冲区的数据写入日志文件，以减少I/O操作进而提升系统性能。因此，在有着较大事务的应用场景中，建议为此变量设定一个更大的值

### 滚动日志
说明：只要是针对二进制日志进行滚动的，
对某个类型的日志文件滚动一次就生成一个新的相对应的日志文件，
通过这种方法保证日志文件的特定大小，
从而保证服务器在对日志文件查询时有较高的响应能力。
#### 滚动二进制日志的命令：
    #mysql> FLUSH LOGS;

