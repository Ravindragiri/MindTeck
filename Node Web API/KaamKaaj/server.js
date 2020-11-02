var mongoose = require('mongoose'),
    debug = require('debug')('Eatery'),
    express = require('express'),
    http = require('http'),
    bodyParser = require('body-parser'),
    config = require('./config/base.config');

var ObjectId = mongoose.Types.ObjectId;

//var port = process.env.port || 31711;
var port = 31711;

var app = express();

app.use(bodyParser.urlencoded({
    extended: true
}));

require('./app/models/menuItemRating.server.modeler.model');
require('./app/models/follower.server.model');
require('./app/models/menuItem.server.model');
require('./app/models/user.server.model');

//app.use(expressLayouts);
app.use(bodyParser.json());

require('./app/routes/api.server.routes.js')(app);
require('./app/routes/all.server.routes.js')(app);

// Create HTTP Server
var httpsServer = http.createServer(app).listen(port);  

mongoose.connect('mongodb://localhost/Eatery');
var db = mongoose.connection;

db.on('error', console.error.bind(console, "connection error"));
db.once('open', function () {
    console.log("Eatery is open...");
});