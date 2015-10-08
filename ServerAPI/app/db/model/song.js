/* Music model */
var mongoose = require('mongoose');

var song = mongoose.Schema({
    song_id: String,
    faid: String,
    name: String,
    album_name: String,
    cover_photo: String,
    cover_photo_url: String,
    album_photo: String,
    album_photo_url: String,
    uploaded_on: String,
    release_date: String,
    size: String,
    duration: String
});

var featured_album = mongoose.Schema({
    faid: String,
    singer_id: String,
    song_name: String,
    album_name: String,
    cover_photo_name: String,
    cover_photo_url: String,
    release_date: String,
    date_added: String
})

var singer_name = mongoose.Schema({
    singer_id: String,
    faid: String,
    song_id: String,
    name: String
})

var video = mongoose.Schema({
    video_id: String,
    video_name: String,
    album_id: String,   // foreign key
    video_file_name: String,
    video_file_url: String,
    release_date: String,
    added_on: String
})

var singers_in_song = mongoose.Schema({
    file_id: String,
    singer_id: String
})

var Song = mongoose.model('Song', song);
var Featured_Album = mongoose.model('Featured_Album', featured_album);
var Singer_Name = mongoose.model('Singer_Name', singer_name);
var Video = mongoose.model('Video', video);
var Singers_In_Song = mongoose.model('Singers_In_Song', singers_in_song);

module.exports = {
    Song: Song,
    Featured_Album: Featured_Album,
    Singer_Name: Singer_Name,
    Video: Video,
    Singers_In_Song: Singers_In_Song
};