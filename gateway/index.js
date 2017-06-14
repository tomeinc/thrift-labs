const thrift = require('thrift');
const CapitalizeService = require('./gen-nodejs/CapitalizeService');
const UncapitalizeService = require('./gen-nodejs/UncapitalizeService');
const ReverseService = require('./gen-nodejs/ReverseService');
const app = require('express')();

const transport = thrift.TBufferedTransport;
const protocol = thrift.TBinaryProtocol;

function createConnection(host, port, thing, errorCallback) {
    const connection = thrift.createConnection(host, port, {
        transport : transport,
        protocol : protocol
    });

    connection.on('error', errorCallback);

    return thrift.createClient(thing, connection);
}

app.get('/reverse/:sometext', (req, res) => {
    const Reverse = createConnection(process.env.REVERSE_HOST, process.env.REVERSE_PORT, ReverseService, (err) => {
        return res.status(500).json({
            name: err.name,
            message: err.message,
            stack: err.stack
        });
    });

    return Reverse.reverse(req.params.sometext)
        .then(result => res.status(200).json(result))
        .catch(err => res.status(500).json(err));
});

app.get('/capitalize/:sometext', (req, res) => {
    const Capitalize = createConnection(process.env.CAPITALIZE_HOST, process.env.CAPITALIZE_PORT, CapitalizeService, (err) => {
        return res.status(500).json({
            name: err.name,
            message: err.message,
            stack: err.stack
        });
    });

    return Capitalize.capitalize(req.params.sometext)
        .then(result => res.status(200).json(result))
        .catch(err => res.status(500).json(err));
});

app.get('/uncapitalize/:sometext', (req, res) => {
    const Uncapitalize = createConnection(process.env.UNCAPITALIZE_HOST, process.env.UNCAPITALIZE_PORT, UncapitalizeService, (err) => {
        return res.status(500).json({
            name: err.name,
            message: err.message,
            stack: err.stack
        });
    });

    return Uncapitalize.uncapitalize(req.params.sometext)
        .then(result => res.status(200).json(result))
        .catch(err => res.status(500).json(err));
});

app.listen(process.env.PORT || 8000);
