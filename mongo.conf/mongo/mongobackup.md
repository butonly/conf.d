mongobackup test
================

mongodb中的副本集搭建实践
http://www.cnblogs.com/visionwang/p/3290435.html


    mongobackup是用于Mongodb的增量备份与恢复工具，恢复时，需要结合全量备份与恢复使用，目前该工具尚未开源。
    该工具可以实时地读取目标mongo实例的oplog，然后以BSON格式存储到文件中，在做数据恢复时通过回放BSON文件中的oplog实现数据的恢复。
    这与Mongodb自身提供的备份恢复工具mongodump和mongorestore类似，但是mongobackup在备份和恢复时可以指定时间戳，即可以备份和恢复指定时间段内的数据，因此可以实现增量。

目前mongobackup还没有完善的使用说明文档，因此希望通过试用摸清该工具的使用方法，验证其功能是否正确，具体流程如下：
	1）加载数据
	2）备份数据
	3）恢复数据

### 加载数据

通过自制脚本插入一定量的数据

### 备份数据

* mongobackup开启流式备份

数据加载到时，启动mongobackup进行流式备份，开始记录mongo实例的oplog，`起始时间戳`为1420446193,1。

通过以下代码查询`起始时间戳`，这里使用最后一条。local.oplog.rs
```js
db.oplog.rs.find().sort({ts: -1}).limit(1);
```

```sh
mongobackup --backup --stream --host= --port=27017 -s 1466169280,94
```

* mongodump数据备份

在启动mongobackup记录oplog的同时，启动mongodump进行部分数据备份，通过执行结果可知mongodump一共备份了5224511条记录

```sh
mongodump --port 27017 -o mongobackup/27017
```

> Note: 先开启流式备份，再开始全量备份，使备份的oplog和全量备份的数据有一定交叉。避免数据缺失。

### stop mongobackup

在数据加载完成后终止mongobackup对于oplog的记录。

此时可以看到通过oplog记录的Objets的个数。以及两个时间戳。`Backuped up to ts: Timestamp 1466234959000|1` `Use -s 1466234959,1 to resume.`

### 恢复数据

> mongodump + mongobackup: 此时mongodump生成的备份文件包含了一部分数据，mongobackup生成的oplog备份文件包含了一部分增量数据，要想获取全量数据必须两者配合。

* mongorestore恢复数据

```sh
mongorestore --host= --port 27017 --drop mongobackup/27017
```

runtime: epollwait on fd 4 failed with 9
2016-06-18T00:36:48.770-0700	building a list of dbs and collections to restore from 27047 dir
2016-06-18T00:36:48.795-0700	reading metadata for myrepl.idschemas from 27047/myrepl/idschemas.metadata.json
2016-06-18T00:36:49.203-0700	restoring myrepl.idschemas from 27047/myrepl/idschemas.bson
2016-06-18T00:36:51.783-0700	[############............]  myrepl.idschemas  4.6 MB/9.0 MB  (51.7%)
2016-06-18T00:36:53.484-0700	[########################]  myrepl.idschemas  9.0 MB/9.0 MB  (100.0%)
2016-06-18T00:36:53.484-0700	restoring indexes for collection myrepl.idschemas from metadata
2016-06-18T00:36:53.484-0700	finished restoring myrepl.idschemas (241361 documents)
2016-06-18T00:36:53.485-0700	done

* mongobackup回放增量数据
通过mongobackup回放oplog来恢复mongodump备份完成之后的增量数据，
通过执行结果可知通过oplog000000.bson回放了3346277条记录，通过oplog000001.bson回放了2014156条记录，
此时再次连接mongo实例查看集合的记录个数为10000000，
与实际加载的记录个数相同

connected to: 127.0.0.1:27017
Sat Jun 18 00:59:47.409 Replaying file:oplog000000.bson
Sat Jun 18 00:59:50.358 		Progress: 13111800/13840083	94%	(bytes)
112521 objects found
Sat Jun 18 00:59:50.370 Successfully Recovered.

```sh
./mongobackup --port 27017 --recovery -s 1420446193,1 -t 1420446841,1
```

### 总结

通过以上过程可知，mongobackup的实现应该是参考了mongodump --oplog和mongorestore --oplogReplay的源码。在使用mongobackup进行增量备份恢复时，数据恢复速度与mongorestore类似，即每秒钟恢复20000条记录。


### 其他

db.idschemas.find().sort({_id:-1}).limit(10);
db.oplog.rs.find().sort({ts: -1}).limit(20);

./mongobackup --port=27047 --backup --stream -s 1466242777,2

./mongobackup --port 27017 --recovery -s 1466240853,1 -t 1466242240,4
