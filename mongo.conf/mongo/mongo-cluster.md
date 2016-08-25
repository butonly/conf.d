

### Deploy the Config Server Replica Set

1. Start all the config servers with both the --configsvr and --replSet <name> options:

mongod -f mongodb.configsrv_27127.conf

mongod --configsvr --fork --replSet=configReplSet --port=27127 --dbpath=/var/lib/mongodb/data/configsrv27127
mongod --configsvr --fork --replSet=configReplSet --port=27128 --dbpath=/var/lib/mongodb/data/configsrv27128
mongod --configsvr --fork --replSet=configReplSet --port=27129 --dbpath=/var/lib/mongodb/data/configsrv27129

2. Connect a mongo shell to one of the config servers and run rs.initiate() to initiate the replica set.

rs.initiate({
   _id: "configReplSet",
   configsvr: true,
   members: [
      { _id: 0, host: "127.0.0.1:27127" },
      { _id: 1, host: "127.0.0.1:27128" },
      { _id: 2, host: "127.0.0.1:27129" }
   ]
})


### Start the mongos Instances

The mongos instances are lightweight and do not require data directories.

You can run a mongos instance on a system that runs other cluster components, such as on an application server or a server running a mongod process. 

By default, a mongos instance runs on port 27017.

1. Start one or more mongos instances. For --configdb, or sharding.configDB, specify the config server replica set name followed by a slash / and at least one of the config server hostnames and ports:

mongos --configdb configReplSet/<cfgsvr1:port1>,<cfgsvr2:port2>,<cfgsvr3:port3>


### Add Shards to the Cluster

A shard can be a standalone mongod or a replica set. 

In a production environment, each shard should be a replica set. 

Use the procedure in Deploy a Replica Set to deploy replica sets for each shard.

1. From a mongo shell, connect to the mongos instance. Issue a command using the following syntax:

mongo --host <hostname of machine running mongos> --port <port mongos listens on>

mongo --host mongos0.example.net --port 27017

2. Add each shard to the cluster using the sh.addShard() method, as shown in the examples below. 

Issue sh.addShard() separately for each shard. 

If the shard is a replica set, specify the name of the replica set and specify a member of the set. 

In production deployments, all shards should be replica sets.


OPTIONAL

You can instead use the addShard database command, which lets you specify a name and maximum size for the shard. 

If you do not specify these, MongoDB automatically assigns a name and maximum size. To use the database command, see addShard.


To add a shard for a replica set named rs1 with a member running on port 27017 on mongodb0.example.net, issue the following command:

sh.addShard( "rs1/mongodb0.example.net:27017" )

To add a shard for a standalone mongod on port 27017 of mongodb0.example.net, issue the following command:

sh.addShard( "mongodb0.example.net:27017" )


### Enable Sharding for a Database

Before you can shard a collection, you must enable sharding for the collection’s database. 

Enabling sharding for a database does not redistribute data but make it possible to shard the collections in that database.

Once you enable sharding for a database, MongoDB assigns a primary shard for that database where MongoDB stores all data before sharding begins.

1. From a mongo shell, connect to the mongos instance. Issue a command using the following syntax:

mongo --host <hostname of machine running mongos> --port <port mongos listens on>

2. Issue the sh.enableSharding() method, specifying the name of the database for which to enable sharding. Use the following syntax:

sh.enableSharding("<database>")

Optionally, you can enable sharding for a database using the enableSharding command, which uses the following syntax:

db.runCommand({enableSharding: <database>})


### Shard a Collection

sh.shardCollection("records.people", { "zipcode": 1, "name": 1 } )
sh.shardCollection("people.addresses", { "state": 1, "_id": 1 } )
sh.shardCollection("assets.chairs", { "type": 1, "_id": 1 } )
sh.shardCollection("events.alerts", { "_id": "hashed" } )

