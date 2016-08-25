
{db: {collection: {document: {key:value, key:value}}}}

#查看数据库
show dbs

#创建数据库
use [databaseName]

#查看文档
show collections

#选择文档
db.[documentName]

#Read Operations

	#普通查询
	var cursor = db.collection.find({/*Query Criteria*/}, {/*Projection*/}).modifier();  //modifier: limits, skips, and sort orders.
	var document = db.collection.findOne({/*Query Criteria*/}, {/*Projection*/});

	var cursor = db.things.find();
	while (cursor.hasNext()) {printjson(cursor.next());}
	cursor.forEach(printjson);
	printjson(cursor[4]);
	printjson(cursor.toArray()[0]);

	db.collection.find().limit(10); #通过limit限制结果集数量

	Projection Behavior MongoDB projections have the following properties:
		 • By default, the _id field is included in the results. To suppress the _id field from the result set, specify _id: 0 in the projection document.
		 • For fields that contain arrays, MongoDB provides the following projection operators:  $elemMatch, $slice, and $.
		 • For related projection functionality in the aggregation framework pipeline, use the $project pipeline stage. 

	#Closure of Inactive Cursors
	var myCursor = db.inventory.find().addOption(DBQuery.Option.noTimeout);
	#Cursor Isolation
	#Cursor Batches
	see batchSize() and limit()
	var cursor = db.inventory.find();
	cursor.objsLeftInBatch();

	db.serverStatus().metrics.cursor

	db.inventory.createIndex( { type: 1 } )  #$nin or $ne

	db.collection.explain()
	cursor.explain()


#Write Operations
	db.collection.insert({/*document*/});
	db.users.insert({name: "sue", age: 26, status: "A"});
	db.users.save({key: 'value'});

	db.collection.initializeUnorderedBulkOp();
	db.collection.initializeOrderedBulkOp();
	• Bulk.insert()
	• Bulk.find()
	• Bulk.find.upsert()
	• Bulk.find.update()
	• Bulk.find.updateOne()
	• Bulk.find.replaceOne()
	• Bulk.find.remove()
	• Bulk.find.removeOne()

	db.collection.update({/*update criteria*/}, {/*update action*/}, {/*update option*/multi: true, upsert: true});
	db.users.update({ age: { $gt: 18 } }, { $set: { status: "A" } }, { multi: true });



	db.collection.remove({/*remove criteria*/}, {/*remove option*/});
	db.users.remove({ status: "D" });

#Aggregation 
	pipeline  		db.collection.aggregate([]);
	Map-Reduce		db.collection.mapReduce();


#Index
db.inventory.createIndex( { field: 1 } )