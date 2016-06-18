var MongoClient = require('mongodb').MongoClient,
    assert = require('assert');

var Promise = require('bluebird');

var count = 1;

// Connection URL
// var url = 'mongodb://localhost:27017/myproject';
// var url = 'mongodb://172.16.137.135,172.16.137.136,172.16.137.137:27017/repl';
var url = 'mongodb://localhost:27027:,localhost:27037,localhost:27037/myrepl';
// Use connect method to connect to the Server

var mongoose = require('mongoose');

mongoose.connect(url, { config: { autoIndex: false } });

var Schema = mongoose.Schema;

var IdSchema = new Schema({
  id:  Number,
});

var Id = mongoose.model('IdSchema', IdSchema);

Promise.resolve(new Array(1000000)).each(function() {
    console.log('---------------', count);
    return new Id({id: count++}).save();
});
