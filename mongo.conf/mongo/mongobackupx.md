


### mongodump

mongodump  --db test --collection collection
mongodump  --db test --excludeCollection=users --excludeCollection=salaries
mongodump --host mongodb1.example.net --port 37017 --username user --password pass --out /opt/backup/mongodump-2011-10-24
mongodump --archive=test.20150715.archive --db test
mongodump --archive --db test --port 27017 | mongorestore --archive --port 27018
mongodump --gzip --db test
mongodump --archive=test.20150715.gz --gzip --db test


mongodb数据量变大后，备份数据就会成为头疼的问题了，备份耗时会越来越长了。下面介绍一款mongodb增量备份与恢复工具mongobackup。
1. 介绍

mongobackup是用于复制集的增量备份与恢复工具。在恢复时，需要结合全量备份与恢复使用。参见：http://pan.baidu.com/s/1u1vwu#dir
2. 增量备份

2.1 全量备份
# mongobackup  -u ttlsa -p 'www.ttlsa.com' --port 27017  -h 10.1.11.99 --backup
# mongobackup --port 27047  --backup

2.2 流模式备份
# mongobackup  -u ttlsa -p 'www.ttlsa.com' --port 27017 –h 10.1.11.99 --backup --stream
mongobackup --port 27047  --backup --stream

2.3 指定备份初始时间点
# mongobackup  -u ttlsa -p 'www.ttlsa.com' --port 27017  -h 10.1.11.99 --backup -s 1385367056,1
mongobackup  --port 27027 --backup -s 1385367056,1

3. 增量 恢复 必须指定起止时间点，配合全备，可以恢复到任意时间点（结束时间点），开始时间点可以理解为全备的时间点。
# mongobackup  -u ttlsa -p 'www.ttlsa.com' --port 27017 -h 10.1.11.99 --recovery   -s 1385367098,27350  -t  1385367132,35490  ./backup/
# mongobackup  -u ttlsa -p 'www.ttlsa.com' --port 27017 -h 10.1.11.99 --recovery   -s 1385367098,27350

mongosync不多说了，全量同步，增量同步等都支持，非常强大； 
mongobackup 增量备份与恢复。
mongo2toku 增量同步，用于向tokumx迁移时用； 

MongoDB复制集自适应oplog管理
时间 2016-06-16 09:35:22  Yun Notes
原文  http://blog.yunnotes.net/index.php/mongodb-adaptive-oplog/
主题 MongoDB
MongoDB复制集运行过程中，经常可能出现Secondary同步跟不上的情况，主要原因是 主备写入速度上有差异，而复制集配置的oplog又太小 ，这时需要人工介入，向Secondary节点发送resync命令。

上述问题可通过配置更大的oplog来规避，目前 官方文档建议的修改方案 步骤比较长，而且需要停写服务来做，大致过程是先把oplog备份，然后再oplog集合删掉，重新创建，再把备份的内容导入到新创建的oplog。


mongodb中的副本集搭建实践
http://www.cnblogs.com/visionwang/p/3290435.html

========================================================================================================================================================
MongoDB实时备份工具mongobackup初体验
 mongobackup是用于Mongodb的增量备份与恢复工具，恢复时，需要结合全量备份与恢复使用，目前该工具尚未开源。该工具可以实时地读取目标mongo实例的oplog，然后以BSON格式存储到文件中，在做数据恢复时通过回放BSON文件中的oplog实现数据的恢复。这与Mongodb自身提供的备份恢复工具mongodump和mongorestore类似，但是mongobackup在备份和恢复时可以指定时间戳，即可以备份和恢复指定时间段内的数据，因此可以实现增量。

 目前mongobackup还没有完善的使用说明文档，因此希望通过试用摸清该工具的使用方法，验证其功能是否正确，具体流程如下：
	1）通过YCSB工具向mongo实例中加载1000W条记录；
	2）在数据加载过程中启动mongodump命令对已加载的数据进行备份，而在执行mongodump命令前先启动mongobackup工具实时记录mongo实例的oplog；
	3）在数据加载完成后停止mongobackup对于oplog的实时记录；
	4）使用mongorestore命令恢复之前通过mongodump备份的部分记录；
	5）使用mongobackup对从mongodump执行到数据完全加载完成这段时间内的数据进行恢复，以添加mongodump没有备份的数据。

根据以上流程执行每一步测试，以下为整个测试过程的结果记录：

1. 加载数据
启动YCSB工具开始加载数据
./bin/ycsb load mongodb -threads 100 -P workloads/readandupdateandinsert1 > load.result

2. mongobackup开启流式备份
待数据加载到一半时，启动mongobackup的流式备份，开始记录mongo实例的oplog，起始时间戳为1420446193,1
[frankey@mongo-server3 ~]$ ./mongobackup --backup --stream --host= --port=27017 -s 1466169280,94
connected to: mongo-server1:27017
Mon Jan  5 16:24:41.188 local.oplog.$main to backup/oplog.bson
Mon Jan  5 16:24:44.003 Backup Progress: 221800/197606 112% (objects)
...

mongodump --port 27047 -o /backup/27047
3. mongodump数据备份
在启动mongobackup记录oplog的同时，启动mongodump进行部分数据备份，通过执行结果可知mongodump一共备份了5224511条记录
[frankey@mongo-server3]$ mongodump --host mongo-server1 --port 27017 -o /data/mongobackup/mongo-server1/27017
connected to: mongo-server1:27017
Mon Jan  5 16:25:15.168 all dbs
Mon Jan  5 16:25:15.169 DATABASE: ycsb to /data/mongobackup/mongo-server1/20006/ycsb
Mon Jan  5 16:25:15.170 ycsb.system.indexes to /data/mongobackup/mongo-server1/27017/ycsb/system.indexes.bson
Mon Jan  5 16:25:15.172 1 objects
Mon Jan  5 16:25:15.172 ycsb.usertable to /data/mongobackup/mongo-server1/27017/ycsb/usertable.bson
Mon Jan  5 16:25:18.005 Collection File Writing Progress: 469900/5169224 9% (objects)
Mon Jan  5 16:25:21.038 Collection File Writing Progress: 1409300/5169224 27% (objects)
Mon Jan  5 16:25:24.030 Collection File Writing Progress: 2348700/5169224 45% (objects)
Mon Jan  5 16:25:27.036 Collection File Writing Progress: 3272500/5169224 63% (objects)
Mon Jan  5 16:25:30.016 Collection File Writing Progress: 4650300/5169224 89% (objects)
Mon Jan  5 16:25:31.764 5224511 objects
Mon Jan  5 16:25:31.764 Metadata for ycsb.usertable to /data/mongobackup/mongo-server1/27017/ycsb/usertable.metadata.json
Mon Jan  5 16:25:31.764 DATABASE: admin to /data/mongobackup/mongo-server1/27017/admin

4. 终止mongobackup
在数据加载完成后终止mongobackup对于oplog的记录，此时可以看到通过oplog共记录了5360433。
此时mongodump生成的备份文件包含了一部分数据，
mongobackup生成的oplog备份文件包含了一部分增量数据，
要想获取全量数据必须两者配合。mongodump + mongobackup
Mon Jan  5 16:33:38.001 Backup Progress: 5268700/197606 2666% (objects)
Mon Jan  5 16:33:41.005 Backup Progress: 5298600/197606 2681% (objects)
Mon Jan  5 16:33:44.001 Backup Progress: 5327700/197606 2696% (objects)
Mon Jan  5 16:33:47.001 Backup Progress: 5353900/197606 2709% (objects)
Mon Jan  5 16:33:56.289 waiting for new ops ^_^
^CMon Jan  5 16:34:05.969 Received signal 2.
Mon Jan  5 16:34:05.969 Will exit soon.
Mon Jan  5 16:34:06.289 waiting for new ops ^_^
Mon Jan  5 16:34:06.290 5360433 objects
Mon Jan  5 16:34:06.290 Backuped up to ts: Timestamp 1420446841000|1
Mon Jan  5 16:34:06.290 Use -s 1420446841,1 to resume.
Mon Jan  5 16:34:06.290 Metadata for oplog000001 to backup/oplog.metadata.json
Mon Jan  5 16:34:06.290 5360433 objects

5. mongorestore恢复数据
假定此时mongo实例出现故障，全部数据丢失，此时通过mongorestore命令将最近一次全量备份数据导入到数据库中，
通过该工具恢复数据共计5224511条，此时连接mongo实例查看集合的记录个数为5224511
[frankey@mongo-server3]$ mongorestore --host mongo-server1 --port 27017 --drop /data/mongobackup/mongo-server1/27017
connected to: mongo-server1:27017
Mon Jan  5 16:36:01.022 /data/mongobackup/mongo-server1/27017/ycsb/usertable.bson
Mon Jan  5 16:36:01.022 going into namespace [ycsb.usertable]
Mon Jan  5 16:36:01.022 dropping
Mon Jan  5 16:36:04.000 Progress: 18993257/1399539468 1% (bytes)
Mon Jan  5 16:36:07.003 Progress: 37049030/1399539468 2% (bytes)
Mon Jan  5 16:36:10.002 Progress: 55961917/1399539468 3% (bytes)
...
Mon Jan  5 16:39:37.000 Progress: 1352035352/1399539468 96% (bytes)
Mon Jan  5 16:39:40.004 Progress: 1371778875/1399539468 98% (bytes)
Mon Jan  5 16:39:43.003 Progress: 1391583177/1399539468 99% (bytes)
5224511 objects found
Mon Jan  5 16:39:44.213 Creating index: { name: "_id_", key: { _id: 1 }, ns: "ycsb.usertable” }

./mongobackup --port 27017 --recovery -s 1466234664,66 -t 1466234959000,1
6. mongobackup回放增量数据
通过mongobackup回放oplog来恢复mongodump备份完成之后的增量数据，
通过执行结果可知通过oplog000000.bson回放了3346277条记录，通过oplog000001.bson回放了2014156条记录，
此时再次连接mongo实例查看集合的记录个数为10000000，
与实际加载的记录个数相同
[frankey@mongo-server3 ~]$ ./mongobackup --port 27017 --host mongo-server1 --recovery -s 1420446193,1 -t 1420446841,1
connected to: mongo-server1:27017
Mon Jan  5 16:43:40.903 Replaying file:oplog000000.bson
Mon Jan  5 16:43:43.006 Progress: 9241298/1073742107 0% (bytes)
Mon Jan  5 16:43:46.004 Progress: 22140667/1073742107 2% (bytes)
Mon Jan  5 16:43:49.005 Progress: 35328590/1073742107 3% (bytes)
...
Mon Jan  5 16:46:31.000 Progress: 1047213189/1073742107 97% (bytes)
Mon Jan  5 16:46:34.003 Progress: 1068134387/1073742107 99% (bytes)
3346277 objects found
Mon Jan  5 16:46:34.792 Replaying file:oplog000001.bson
Mon Jan  5 16:46:37.003 Progress: 15658789/646295159 2% (bytes)
Mon Jan  5 16:46:40.004 Progress: 37414205/646295159 5% (bytes)
...
Mon Jan  5 16:48:07.005 Progress: 614799792/646295159 95% (bytes)
Mon Jan  5 16:48:10.006 Progress: 635047026/646295159 98% (bytes)
2014156 objects found
Mon Jan  5 16:48:11.677 Successfully Recovered.

7. 继续
继续通过YCSB命令执行压力测试，已验证恢复后数据的完整性，
该测试共执行1000W条操作，90%read、5%update和5%insert，
通过执行结果可知update和insert执行操作全部成功，而read操作有12个失败，导致read操作失败的原因是否因为数据恢复有问题暂时无法确定，
YCSB也没有提供更详细的失败原因，
所以使用mongodump+mongorestore+mongobackup来实现增量备份是否可靠还需要进一步确认。
[frankey@mongo-server3 ycsb-0.1.4]$ ./bin/ycsb run mongodb -threads 100 -P workloads/readandupdateandinsert1 > run.result
[UPDATE], Operations, 499944
[UPDATE], AverageLatency(us), 20879.322764149583
[UPDATE], MinLatency(us), 150
[UPDATE], MaxLatency(us), 1428679
[UPDATE], 95thPercentileLatency(ms), 64
[UPDATE], 99thPercentileLatency(ms), 97
[UPDATE], Return=0, 499944
[INSERT], Operations, 499827
[INSERT], AverageLatency(us), 21033.383328631706
[INSERT], MinLatency(us), 172
[INSERT], MaxLatency(us), 1485376
[INSERT], 95thPercentileLatency(ms), 64
[INSERT], 99thPercentileLatency(ms), 97
[INSERT], Return=0, 499827
[READ], Operations, 9000229
[READ], AverageLatency(us), 4457.124366946663
[READ], MinLatency(us), 83
[READ], MaxLatency(us), 1346130
[READ], 95thPercentileLatency(ms), 15
[READ], 99thPercentileLatency(ms), 36
[READ], Return=0, 9000217
[READ], Return=1, 12

通过以上过程可知，mongobackup的实现应该是参考了mongodump --oplog和mongorestore --oplogReplay的源码。在使用mongobackup进行增量备份恢复时，数据恢复速度与mongorestore类似，即每秒钟恢复20000条记录。
