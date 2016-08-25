1. 	Start each member of the replica set with the appropriate options.

> For each member, start a mongod and specify the replica set name through the replSet option. 

Replication Options:

* --replSet <setname>
* --oplogSize <value>
* --replIndexPrefetch
* --enableMajorityReadConcern


mongod --replSet "rs0"

创建三个Mongod实例，端口分别为27027 27037 27047
mongod --config $HOME/.mongodb/config

mkdir -p /srv/mongodb/rs0-0 /srv/mongodb/rs0-1 /srv/mongodb/rs0-2

sudo mongod --port 27027 --dbpath /srv/mongodb/rs0-0 --replSet rs0 --smallfiles --oplogSize 128
sudo mongod --port 27037 --dbpath /srv/mongodb/rs0-1 --replSet rs0 --smallfiles --oplogSize 128
sudo mongod --port 27047 --dbpath /srv/mongodb/rs0-2 --replSet rs0 --smallfiles --oplogSize 128


2. Connect a mongo shell to a replica set member.

mongo --port=27017

3. Initiate the replica set.

Use rs.initiate() on one and only one member of the replica set:
rs.initiate(
   {
      _id: "myrepl",
      version: 1,
      members: [
         { _id: 0, host : "127.0.0.1:27027" },
         { _id: 1, host : "127.0.0.1:27037" },
         { _id: 2, host : "127.0.0.1:27047" }
      ]
   }
);

4. Verify the initial replica set configuration.

rs.conf()

5. Add the remaining members to the replica set.

> Add the remaining members with the `rs.add()` method. You must be connected to the primary to add members to a replica set.

rs.add("mongodb1.example.net")
rs.add("mongodb2.example.net")

6. Check the status of the replica set.
