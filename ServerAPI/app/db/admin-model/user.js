/* Music model */
var mongoose = require('mongoose');
var user = mongoose.Schema({
    username: String,
    password: String,
    type: String
});

var User = mongoose.model('User', user);

module.exports = {
    User: User
};