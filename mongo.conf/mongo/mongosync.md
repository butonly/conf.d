MongoDB数据同步工具mongosync介绍及下载
由 ccj 在 3 年前 发布 11725 次点击
说明
本软件免费使用。
免责申明
使用前请先测试，使用本软件造成一切后果与本社区及本人无关。
许可证
目前使用Apache Licene 2.0

mongosync下载地址:
http://dl.nosqldb.org/mongosync
使用手册：
http://dl.nosqldb.org/mongosync_user_guide_zh_CN.pdf

默认认证admin库。
mongosync是什么
mongosync是用于MongoDB复制集之间，复制集到分片集群之间以及分片集群与分片集群之间同步数据的一个工具。

mongosync使用场景
1.实时迁移，尤其是从一个集群迁移到另一个集群，或者master-slave架构迁移到replica sets架构
2.实时同步，比如同步数据到其他集群。
3.其他场景

mongosync特点及功能增强
1.极速（ssd环境最大能达到百万每秒）、易用；
2.支持全量同步，增量同步，支持同步单库、单集合；
3.支持实时监测数据的变化并同步，类似tail -f效果，即使在同步过程中及以后新产生的数据也能同步到目标库；
4.支持MongoDB 1.8.x,MongoDB 2.0.x,MongoDB 2.4.x版本的同步，
支持master-slave到replica sets架构的同步，
支持replica sets到replica sets架构的同步，
支持replica sets到sharding cluster的同步；

集群间实时迁移方法：

直接使用mongosync 全量同步+增量同步功能同步数据到目标库（—oplog参数）

几个使用方法：
全量同步

mongosync -h 10.0.4.91:27017 -u admin -p 123 --to 10.0.4.91:27020 --tu admin --tp 456
增量同步

mongosync -h 10.0.4.91:27017 -u admin -p 123 --to 10.0.4.91:27020 --tu admin --tp 456 --oplog -s 1369406664,1  
“初始化”同步（全量+增量+实时）

mongosync -h 10.0.4.91:27017 -u admin -p 123 --to 10.0.4.91:27020 --tu admin --tp 456 --oplog 
同步一段时间范围内的数据

mongosync -h 10.0.4.91:27017 -u admin -p 123 --to 10.0.4.91:27020 --tu admin --tp 456 --oplog -s 1369811325,1 -t 1369811373,1 
支持平台：
x86-64 centos 6.x

