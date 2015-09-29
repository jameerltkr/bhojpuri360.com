// Multer found upload 
var multer = require('multer');
// Dateformat
var dateFormat = require('dateformat');

var fs = require('fs');

var song = require('../app/db/model/song.js');

module.exports = function (app, socket) {

	app.post('/admin/upload-coverphoto', multer({
		dest: './files/coverphoto/',
		rename: function (fieldname, filename, req, res) {
			console.log('renaming coverphoto')

			console.log('fieldname'+fieldname)
			console.log(filename);

			var song_name = req.query.song_name;

			console.log('Song name while renaming: '+song_name)

			// Date time
			var date = new Date();

			var day = dateFormat(date.request_date, "yyyy-mm-dd_h-MM-ss");

			var renamed_name = day + '_' + song_name + '_coverphoto';

			req.session.coverphoto = renamed_name;

			return renamed_name;
		},
		onFileUploadStart: function (file) {
		},
		onFileUploadData: function (file, data, req, res) {
		},
		onFileUploadComplete: function (file, req, res) {
			console.log('photo uploaded');

			console.log(req.session.songname);

			console.log('filename '+req.session.songname + '.mp3')

			song.Song.findOne({
				name: req.session.songname + '.mp3'
			}, function(err, data){
				if(data){
					data.cover_photo = file.name;

					data.save(function(err){
						if(err)
							res.send('Error while saving');
					})
				}
			})

			done = true;
		},
		onError: function (err, next) {

			console.log('File uploading error : ' + err);
			
			//res.send('Error while uploading the file');
			
			next(err);
		}
	}), function (req, res) {
		console.log('1');
		res.send('Cover photo uploaded successfully');
	});
	
	app.post('/admin/upload-albumphoto', multer({
		dest: './files/albumphoto/',
		rename: function (fieldname, filename, req, res) {
			var album_name = req.query.album_name;

			// Date time
			var date = new Date();

			console.log('renaming album photo')

			console.log('ffafa '+filename)

			var day = dateFormat(date.request_date, "yyyy-mm-dd_h-MM-ss");

			var renamed_name = day + '_' + album_name;

			req.session.albumphoto = renamed_name;

			return renamed_name;
		},
		onFileUploadStart: function (file) {
		},
		onFileUploadData: function (file, data, req, res) {
		},
		onFileUploadComplete: function (file, req, res) {
			console.log('albumphoto uploaded');

			

			song.Song.findOne({
				name: req.session.songname + '.mp3'
			}, function(err, data){
				if(data){
					data.album_photo = file.name;

					data.save(function(err){
						if(err)
							res.send('Error while saving');
					})
				}
			})

			done = true;
		},
		onError: function (err, next) {

			console.log('File uploading error : ' + err);
			
			//res.send('Error while uploading the file');
			
			next(err);
		}
	}), function (req, res) {
		console.log('2');
		res.send('album photo uploaded successfully');
	});

	app.post('/admin/upload-song', multer({
		dest: './files/songs/',
		rename: function (fieldname, filename, req, res) {
			var song_name = req.query.song_name;

			var renamed_name = song_name;

			console.log('Saving song name to session: '+renamed_name)

			req.session.songname = renamed_name;

			return renamed_name;
		},
		onFileUploadStart: function (file) {
		},
		onFileUploadData: function (file, data, req, res) {
		},
		onFileUploadComplete: function (file, req, res) {
			console.log('File uploaded');

			done = true;
		},
		onError: function (err, next) {

			console.log('File uploading error : ' + err);
			
			//res.send('Error while uploading the file');
			
			next(err);
		}
	}), function (req, res) {
		console.log('3');

		console.log('Param: ' + req.body.parameter);
		console.log('song name: ' + JSON.parse(req.body.parameter).song_name);

		var song_name = JSON.parse(req.body.parameter).song_name;
		var album_name = JSON.parse(req.body.parameter).album_name;

		console.log('details are--------------');

		console.log('Cover photo: '+req.session.coverphoto)
		console.log('Album photo: '+req.session.albumphoto);
		console.log('Song Name: '+req.session.songname)

		// saving records in db

		var songCollection = song.Song({
			name: req.session.songname + '.mp3',
			album_name: album_name,
			uploaded_on: new Date()
		})

		songCollection.save(function(err){
			if(err){
				res.send('Error while saving data '+err);
			}else{
				res.send('Saved in db');
			}
		})

	});


};
