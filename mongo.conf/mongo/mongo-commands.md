Database Commands
=================

On this page

User Commands
Database Operations
Internal Commands
Testing Commands
Auditing Commands
All command documentation outlined below describes a command and its available parameters and provides a document template or prototype for each command. Some command documentation also includes the relevant mongo shell helpers.

To run a command, use the db.runCommand():

db.runCommand( { <command> } )
NOTE
For details on specific commands, including syntax and examples, click on the specific command to go to its reference page.
User Commands

Aggregation Commands

Name	Description
aggregate	Performs aggregation tasks such as group using the aggregation framework.
count	Counts the number of documents in a collection.
distinct	Displays the distinct values found for a specified key in a collection.
group	Groups documents in a collection by the specified key and performs simple aggregation.
mapReduce	Performs map-reduce aggregation for large data sets.
Geospatial Commands

Name	Description
geoNear	Performs a geospatial query that returns the documents closest to a given point.
geoSearch	Performs a geospatial query that uses MongoDB’s haystack index functionality.
Query and Write Operation Commands

Name	Description
find	Selects documents in a collection.
insert	Inserts one or more documents.
update	Updates one or more documents.
delete	Deletes one or more documents.
findAndModify	Returns and modifies a single document.
getMore	Returns batches of documents currently pointed to by the cursor.
getLastError	Returns the success status of the last operation.
getPrevError	Returns status document containing all errors since the last resetError command.
resetError	Resets the last error status.
eval	Deprecated. Runs a JavaScript function on the database server.
parallelCollectionScan	Lets applications use multiple parallel cursors when reading documents from a collection.
Query Plan Cache Commands

Name	Description
planCacheListFilters	Lists the index filters for a collection.
planCacheSetFilter	Sets an index filter for a collection.
planCacheClearFilters	Clears index filter(s) for a collection.
planCacheListQueryShapes	Displays the query shapes for which cached query plans exist.
planCacheListPlans	Displays the cached query plans for the specified query shape.
planCacheClear	Removes cached query plan(s) for a collection.
Database Operations

Authentication Commands

Name	Description
logout	Terminates the current authenticated session.
authenticate	Starts an authenticated session using a username and password.
copydbgetnonce	This is an internal command to generate a one-time password for use with the copydb command.
getnonce	This is an internal command to generate a one-time password for authentication.
authSchemaUpgrade	Supports the upgrade process for user data between version 2.4 and 2.6.
User Management Commands

Name	Description
createUser	Creates a new user.
updateUser	Updates a user’s data.
dropUser	Removes a single user.
dropAllUsersFromDatabase	Deletes all users associated with a database.
grantRolesToUser	Grants a role and its privileges to a user.
revokeRolesFromUser	Removes a role from a user.
usersInfo	Returns information about the specified users.
Role Management Commands

Name	Description
createRole	Creates a role and specifies its privileges.
updateRole	Updates a user-defined role.
dropRole	Deletes the user-defined role.
dropAllRolesFromDatabase	Deletes all user-defined roles from a database.
grantPrivilegesToRole	Assigns privileges to a user-defined role.
revokePrivilegesFromRole	Removes the specified privileges from a user-defined role.
grantRolesToRole	Specifies roles from which a user-defined role inherits privileges.
revokeRolesFromRole	Removes specified inherited roles from a user-defined role.
rolesInfo	Returns information for the specified role or roles.
invalidateUserCache	Flushes the in-memory cache of user information, including credentials and roles.
Replication Commands

Name	Description
replSetFreeze	Prevents the current member from seeking election as primary for a period of time.
replSetGetStatus	Returns a document that reports on the status of the replica set.
replSetInitiate	Initializes a new replica set.
replSetMaintenance	Enables or disables a maintenance mode, which puts a secondary node in a RECOVERING state.
replSetReconfig	Applies a new configuration to an existing replica set.
replSetStepDown	Forces the current primary to step down and become a secondary, forcing an election.
replSetSyncFrom	Explicitly override the default logic for selecting a member to replicate from.
resync	Forces a mongod to re-synchronize from the master. For master-slave replication only.
applyOps	Internal command that applies oplog entries to the current data set.
isMaster	Displays information about this member’s role in the replica set, including whether it is the master.
replSetGetConfig	Returns the replica set’s configuration object.
SEE ALSO
Replication for more information regarding replication.
Sharding Commands

Name	Description
flushRouterConfig	Forces an update to the cluster metadata cached by a mongos.
addShard	Adds a shard to a sharded cluster.
cleanupOrphaned	Removes orphaned data with shard key values outside of the ranges of the chunks owned by a shard.
checkShardingIndex	Internal command that validates index on shard key.
enableSharding	Enables sharding on a specific database.
listShards	Returns a list of configured shards.
removeShard	Starts the process of removing a shard from a sharded cluster.
getShardMap	Internal command that reports on the state of a sharded cluster.
getShardVersion	Internal command that returns the config server version.
mergeChunks	Provides the ability to combine chunks on a single shard.
setShardVersion	Internal command to sets the config server version.
shardCollection	Enables the sharding functionality for a collection, allowing the collection to be sharded.
shardingState	Reports whether the mongod is a member of a sharded cluster.
unsetSharding	Internal command that affects connections between instances in a MongoDB deployment.
split	Creates a new chunk.
splitChunk	Internal command to split chunk. Instead use the methods sh.splitFind() and sh.splitAt().
splitVector	Internal command that determines split points.
medianKey	Deprecated internal command. See splitVector.
moveChunk	Internal command that migrates chunks between shards.
movePrimary	Reassigns the primary shard when removing a shard from a sharded cluster.
isdbgrid	Verifies that a process is a mongos.
SEE ALSO
Sharding for more information about MongoDB’s sharding functionality.
Instance Administration Commands

Name	Description
renameCollection	Changes the name of an existing collection.
copydb	Copies a database from a remote host to the current host.
dropDatabase	Removes the current database.
listCollections	Returns a list of collections in the current database.
drop	Removes the specified collection from the database.
create	Creates a collection and sets collection parameters.
clone	Copies a database from a remote host to the current host.
cloneCollection	Copies a collection from a remote host to the current host.
cloneCollectionAsCapped	Copies a non-capped collection as a new capped collection.
convertToCapped	Converts a non-capped collection to a capped collection.
filemd5	Returns the md5 hash for files stored using GridFS.
createIndexes	Builds one or more indexes for a collection.
listIndexes	Lists all indexes for a collection.
dropIndexes	Removes indexes from a collection.
fsync	Flushes pending writes to the storage layer and locks the database to allow backups.
clean	Internal namespace administration command.
connPoolSync	Internal command to flush connection pool.
connectionStatus	Reports the authentication state for the current connection.
compact	Defragments a collection and rebuilds the indexes.
collMod	Add flags to collection to modify the behavior of MongoDB.
reIndex	Rebuilds all indexes on a collection.
setParameter	Modifies configuration options.
getParameter	Retrieves configuration options.
repairDatabase	Repairs any errors and inconsistencies with the data storage.
repairCursor	Returns a cursor that iterates over all valid documents in a collection.
touch	Loads documents and indexes from data storage to memory.
shutdown	Shuts down the mongod or mongos process.
logRotate	Rotates the MongoDB logs to prevent a single file from taking too much space.
killOp	Terminates an operation as specified by the operation ID.
Diagnostic Commands

Name	Description
explain	Returns information on the execution of various operations.
listDatabases	Returns a document that lists all databases and returns basic database statistics.
dbHash	Returns hash value a database and its collections.
driverOIDTest	Internal command that converts an ObjectId to a string to support tests.
listCommands	Lists all database commands provided by the current mongod instance.
availableQueryOptions	Internal command that reports on the capabilities of the current MongoDB instance.
buildInfo	Displays statistics about the MongoDB build.
collStats	Reports storage utilization statics for a specified collection.
connPoolStats	Reports statistics on the outgoing connections from this MongoDB instance to other MongoDB instances in the deployment.
shardConnPoolStats	Reports statistics on a mongos‘s connection pool for client operations against shards.
dbStats	Reports storage utilization statistics for the specified database.
cursorInfo	Removed in MongoDB 3.2. Replaced with metrics.cursor.
dataSize	Returns the data size for a range of data. For internal use.
diagLogging	Provides a diagnostic logging. For internal use.
getCmdLineOpts	Returns a document with the run-time arguments to the MongoDB instance and their parsed options.
netstat	Internal command that reports on intra-deployment connectivity. Only available for mongos instances.
ping	Internal command that tests intra-deployment connectivity.
profile	Interface for the database profiler.
validate	Internal command that scans for a collection’s data and indexes for correctness.
top	Returns raw usage statistics for each database in the mongod instance.
whatsmyuri	Internal command that returns information on the current client.
getLog	Returns recent log messages.
hostInfo	Returns data that reflects the underlying host system.
serverStatus	Returns a collection metrics on instance-wide resource utilization and status.
features	Reports on features available in the current MongoDB instance.
isSelf	Internal command to support testing.
Internal Commands

Name	Description
handshake	Internal command.
_recvChunkAbort	Internal command that supports chunk migrations in sharded clusters. Do not call directly.
_recvChunkCommit	Internal command that supports chunk migrations in sharded clusters. Do not call directly.
_recvChunkStart	Internal command that facilitates chunk migrations in sharded clusters.. Do not call directly.
_recvChunkStatus	Internal command that returns data to support chunk migrations in sharded clusters. Do not call directly.
_replSetFresh	Internal command that supports replica set election operations.
mapreduce.shardedfinish	Internal command that supports map-reduce in sharded cluster environments.
_transferMods	Internal command that supports chunk migrations. Do not call directly.
replSetHeartbeat	Internal command that supports replica set operations.
replSetGetRBID	Internal command that supports replica set operations.
_migrateClone	Internal command that supports chunk migration. Do not call directly.
replSetElect	Internal command that supports replica set functionality.
writeBacksQueued	Internal command that supports chunk migrations in sharded clusters.
writebacklisten	Internal command that supports chunk migrations in sharded clusters.
Testing Commands

Name	Description
testDistLockWithSkew	Internal command. Do not call this directly.
testDistLockWithSyncCluster	Internal command. Do not call this directly.
captrunc	Internal command. Truncates capped collections.
emptycapped	Internal command. Removes all documents from a capped collection.
godinsert	Internal command for testing.
_hashBSONElement	Internal command. Computes the MD5 hash of a BSON element.
journalLatencyTest	Tests the time required to write and perform a file system sync for a file in the journal directory.
sleep	Internal command for testing. Forces MongoDB to block all operations.
replSetTest	Internal command for testing replica set functionality.
forceerror	Internal command for testing. Forces a user assertion exception.
skewClockCommand	Internal command. Do not call this command directly.
configureFailPoint	Internal command for testing. Configures failure points.
Auditing Commands¶

Name	Description
logApplicationMessage	Posts a custom message to the audit log.
