// Multer found upload 
var multer = require('multer');

var crypto = require('crypto');
// Dateformat
var dateFormat = require('dateformat');

var fs = require('fs');

var song = require('../app/db/model/song.js');

var featured_album = require('../app/db/model/song.js');

var singer_name_model = require('../app/db/model/song.js')

module.exports = function (app, socket) {

	function randomValueHex (len) {
    	return crypto.randomBytes(Math.ceil(len/2))
        	.toString('hex') // convert to hexadecimal format
        	.slice(0,len);   // return required number of characters
	}


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

	
	app.post('/admin/upload-album', multer({
		dest: './files/albums/',
		rename: function (fieldname, filename, req, res) {
			
			console.log('Song name is '+req.query.song_name)

			var song_name = req.query.song_name;

			// Date time
			var date = new Date();

			var day = dateFormat(date.request_date, "yyyy-mm-dd_h-MM-ss");

			var renamed_name = song_name + '_' + day;

			return renamed_name;
		},
		onFileUploadStart: function (file) {
		},
		onFileUploadData: function (file, data, req, res) {
		},
		onFileUploadComplete: function (file, req, res) {
			console.log('File uploaded');

			console.log('Song name is '+JSON.parse(req.body.parameter).song_name)
		console.log('Album name is; '+JSON.parse(req.body.parameter).album_name);

		console.log('File name is:  '+file.name)

		var song_name = JSON.parse(req.body.parameter).song_name;

		var album_name = JSON.parse(req.body.parameter).album_name;

		var singer_name = JSON.parse(req.body.parameter).singer_name;

		var singer_id = JSON.parse(req.body.parameter).singer_id;

		var filename = file.name;

		var filepath = file.path;

		

		var collection = featured_album.Featured_Album({
			
			song_name: song_name,
			album_name: album_name,
			cover_photo_name: filename,
			cover_photo_url: filepath,
			date_added: new Date(),
			singer_id: singer_id
		});

		//var collection2 = singer_name_model.Singer_Name({
		//	faid: faid,
		//	name: singer_name
		//})

		//collection2.save(function(){})

		collection.save(function(err){
			if(err){
				console.log('Error while saving')
				res.send({
					status: false,
					message: 'Error: ' + err
				})
			}else{
				console.log("Saved in database");

				res.send({
					status: true,
					message: 'Successfully saved in database'
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
	}), function (req, res){
	})

app.post('/admin/add-singer', function (req, res){

	console.log('Name is:  '+req.body.singer_name);
	var singer_name = req.body.singer_name;

	var singer_id = randomValueHex(10);

	var collection2 = singer_name_model.Singer_Name({
		singer_id: singer_id,
		name: singer_name
	})

	collection2.save(function(err){
		if(err)
			res.send('Error while saving singer name in database')
		else
			res.send('Singer name saved in database')
	})
})


};
