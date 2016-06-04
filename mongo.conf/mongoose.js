
/**
 * ```Mongoose```
 * 
 * Mongoose#createConnection([uri], [options])
 * Mongoose#Collection()
 * Mongoose#connect(uri(s), [options], [callback])
 * Mongoose#disconnect([fn])
 * 
 * Mongoose#connection
 * Mongoose#connections
 * 
 * Mongoose#model(name, [schema], [collection], [skipInit])
 * Mongoose#modelNames()
 * Mongoose#Model()
 * Mongoose#models
 * 
 * Mongoose#set(key, value)
 * Mongoose#get(key)
 * 
 * Mongoose()
 * Mongoose#Mongoose()
 * 
 * Mongoose#plugin(fn, [opts])
 * Mongoose#plugins
 * 
 * Mongoose#Promise()
 * Mongoose#Query()
 * Mongoose#Document()
 * Mongoose#Error()
 * 
 * Mongoose#Schema()
 * Mongoose#SchemaType()
 * Mongoose#SchemaTypes
 * 
 * Mongoose#VirtualType()
 * 
 * Mongoose#mongo
 * 
 * Mongoose#mquery
 * 
 * Mongoose#SchemaTypes
 * Mongoose#Types
 * 
 * Mongoose#STATUS
 * 
 * Mongoose#version
 */

/**
 * ```Connection```
 *
 * Connection(base)
 * Connection#open(connection_string, [database], [port], [options], [callback])
 * Connection#openSet(uris, [database], [options], [callback])
 * Connection#close([callback])
 * Connection#collection(name, [options])
 * Connection#collections
 * Connection#db
 * Connection#global
 * Connection#readyState
 * 
 * Connection#model(name, [schema], [collection])
 * Connection#modelNames()
 */

/**
 * ```Error```
 *
 * MongooseError#messages
 * ValidationError#toString()
 */

/**
 * ```NativeConnection```
 *
 * NativeConnection#useDb(name)
 * NativeConnection.STATES
 * NativeCollection#getIndexes(callback)
 */

/**
 * ```Query```
 *
 * Query#$where(js)
 * Query#all([path], val)
 * Query#and(array)
 * Query#batchSize(val)
 * Query#box(val, Upper)
 * Query#cast(model, [obj])
 * Query#center()
 * Query#centerSphere([path], val)
 * Query#circle([path], area)
 * Query#comment(val)
 * Query#count([criteria], [callback])
 * Query#distinct([field], [criteria], [callback])
 * Query#elemMatch(path, criteria)
 * Query#equals(val)
 * Query#exec([operation], [callback])
 * Query#exists([path], val)
 * Query#find([criteria], [callback])
 * Query#findOne([criteria], [projection], [callback])
 * Query#findOneAndRemove([conditions], [options], [callback])
 * Query#findOneAndUpdate([query], [doc], [options], [callback])
 * Query#geometry(object)
 * Query#gt([path], val)
 * Query#gte([path], val)
 * Query#hint(val)
 * Query#in([path], val)
 * Query#intersects([arg])
 * Query#lean(bool)
 * Query#limit(val)
 * Query#lt([path], val)
 * Query#lte([path], val)
 * Query#maxDistance([path], val)
 * Query#maxscan()
 * Query#maxScan(val)
 * Query#merge(source)
 * Query#mod([path], val)
 * Query#ne([path], val)
 * Query#near([path], val)
 * Query#nearSphere()
 * Query#nin([path], val)
 * Query#nor(array)
 * Query#or(array)
 * Query#polygon([path], [coordinatePairs...])
 * Query#populate(path, [select], [model], [match], [options])
 * Query#read(pref, [tags])
 * Query#regex([path], val)
 * Query#remove([criteria], [callback])
 * Query#select(arg)
 * Query#selected()
 * Query#selectedExclusively()
 * Query#selectedInclusively()
 * Query#setOptions(options)
 * Query#size([path], val)
 * Query#skip(val)
 * Query#slaveOk(v)
 * Query#slice([path], val)
 * Query#snapshot()
 * Query#sort(arg)
 * Query#stream([options])
 * Query#tailable(bool)
 * Query#toConstructor()
 * Query#update([criteria], [doc], [options], [callback])
 * Query#where([path], [val])
 * Query#within()
 * Query#use$geoWithin
 */

/**
 * ```Mode```
 *
 * Model(doc)
 * Model#$where(argument)
 * Model#increment()
 * Model#model(name)
 * Model#remove((err,)
 * Model#save(product,)
 * 
 * Model.aggregate([...], [callback])
 * Model.count(conditions, [callback])
 * Model.discriminator(name, schema)
 * Model.distinct(field, [conditions], [callback])
 * Model.ensureIndexes([cb])
 *
 * Model.create(doc(s), [fn])
 *
 * Model.remove(conditions, [callback])
 * 
 * Model.update(conditions, doc, [options], [callback])
 * 
 * Model.find(conditions, [projection], [options], [callback])
 * Model.findById(id, [projection], [options], [callback])
 * Model.findByIdAndRemove(id, [options], [callback])
 * Model.findByIdAndUpdate(id, [update], [options], [callback])
 * Model.findOne([conditions], [projection], [options], [callback])
 * Model.findOneAndRemove(conditions, [options], [callback])
 * Model.findOneAndUpdate([conditions], [update], [options], [callback])
 * 
 * Model.geoNear(GeoJSON, options, [callback])
 * Model.geoSearch(condition, options, [callback])
 * Model.hydrate(obj)
 * Model.mapReduce(o, [callback])
 * Model.populate(docs, options, [cb(err,doc)])
 * 
 * Model.where(path, [val])
 * 
 * Model#base
 * Model#collection
 * Model#db
 * Model#discriminators
 * Model#modelName
 * Model#schema
 */

/**
 * ```Document```
 *
 * Document#equals(doc)
 * Document#execPopulate()
 * Document#get(path, [type])
 * Document#inspect()
 * Document#invalidate(path, errorMsg, value)
 * Document#isDirectModified(path)
 * Document#isInit(path)
 * Document#isModified([path])
 * Document#isSelected(path)
 * Document#markModified(path)
 * Document#modifiedPaths()
 * Document#populate([path], [callback])
 * Document#populated(path)
 * Document#set(path, val, [type], [options])
 * Document#toJSON(options)
 * Document#toObject([options])
 * Document#toString()
 * Document#update(doc, options, callback)
 * Document#validate(optional)
 * Document#validateSync()
 * Document#errors
 * Document#id
 * Document#isNew
 * Document#schema
 */

/**
 * ```Collection```
 *
 * Collection(name, conn, opts)
 * Collection#ensureIndex()
 * Collection#find()
 * Collection#findAndModify()
 * Collection#findOne()
 * Collection#getIndexes()
 * Collection#insert()
 * Collection#mapReduce()
 * Collection#save()
 * Collection#update()
 * Collection#conn
 * Collection#name
 */