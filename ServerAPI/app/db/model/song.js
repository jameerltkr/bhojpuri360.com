/* Music model */
var mongoose = require('mongoose');
var song = mongoose.Schema({
    name: String,
    album_name: String,
    cover_photo: String,
    cover_photo_url: String,
    album_photo: String,
    album_photo_url: String,
    uploaded_on: String,
    size: String,
    duration: String
});

var Song = mongoose.model('Song', song);

module.exports = {
    Song: Song
};