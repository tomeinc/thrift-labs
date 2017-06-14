var thrift = require('thrift');
var CapitalizeService = require('./gen-nodejs/CapitalizeService');
var types = require('./gen-nodejs/capitalize_types');

var server = thrift.createServer(CapitalizeService, {
    capitalize: (text) => text.toUpperCase()
});

server.listen(process.env.PORT || 9000);
