/* Music model */
var mongoose = require('mongoose');
var music = mongoose.Schema({
    id: Number,
    name: String,
    url: String,
    description: String
});

var Music = mongoose.model('Music', music);

module.exports = {
    Music: Music
};