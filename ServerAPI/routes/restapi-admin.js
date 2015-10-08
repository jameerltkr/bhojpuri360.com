// Multer found upload 
var multer = require('multer');

var crypto = require('crypto');
// Dateformat
var dateFormat = require('dateformat');

var busboy = require('connect-busboy'); //middleware for form/file upload

var fs_extra = require('fs-extra');       //File System - for file manipulation

var fs = require('fs');

var song = require('../app/db/model/song.js');

var status = false;

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
			
			console.log('Song name is '+req.query.album_name)

			var album_name = req.query.album_name;

			// Date time
			var date = new Date();

			var day = dateFormat(date.request_date, "yyyy-mm-dd_h-MM-ss");

			var renamed_name = album_name + '_' + day;

			return renamed_name;
		},
		onFileUploadStart: function (file) {
		},
		onFileUploadData: function (file, data, req, res) {
		},
		onFileUploadComplete: function (file, req, res) {
			console.log('File uploaded');

		console.log('Album name is; '+JSON.parse(req.body.parameter).album_name);

		console.log('File name is:  '+file.name)

		var album_name = JSON.parse(req.body.parameter).album_name;

		var filename = file.name;

		var filepath = file.path;

		var faid = randomValueHex(10);

		var collection = song.Featured_Album({
			faid: faid,
			album_name: album_name,
			cover_photo_name: filename,
			cover_photo_url: filepath,
			date_added: new Date()
		});

		//var collection2 = singer_name_model.Singer_Name({
		//	faid: faid,
		//	name: singer_name
		//})

		//collection2.save(function(){})

		collection.save(function(err){
			if(err){
				console.log('Error while saving')

				req.session.status = true;

			}else{
				console.log("Album Saved in database");

				req.session.status = false;
			}
		})

		for(var i = 0; i < JSON.parse(req.body.parameter).singer_list.length; i++){

			var singer_id = randomValueHex(10);

			var singer_name = JSON.parse(req.body.parameter).singer_list[i].name;

			var collection2 = song.Singer_Name({
				singer_id: singer_id,
				name: singer_name,
				faid: faid
			})

			collection2.save(function(err){
				if(err)
					req.session.status = true;
					//res.send('Error while saving singer name in database')
				else{

					//res.send('Singer name saved in database')
					console.log('Singer name saved in database')
					
						

					
				}
			})

			//console.log('name is : '+JSON.parse(req.body.parameter).singer_list[i].name)
		}

		



			done = true;
		},
		onError: function (err, next) {

			console.log('File uploading error : ' + err);
			
			//res.send('Error while uploading the file');
			
			next(err);
		}
	}), function (req, res){
		console.log('Helllo')
		req.session.status = "";

		res.send({
							status: true,
							message: 'Successfully saved in database'
						})
	})

app.post('/admin/add-singer', function (req, res){

	console.log('Name is:  '+req.body.singer_name);
	var singer_name = req.body.singer_name;

	var singer_id = randomValueHex(10);

	var collection2 = song.Singer_Name({
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

app.post('/admin/add-fa', function (req, res){

	var album_name = req.body.album_name;
	
	var release_date = req.body.release_date;

	var faid = randomValueHex(10);


	for(var i = 0; i < req.body.singer_list.length; i++){



		console.log('name is : '+req.body.singer_list[i].name)
	}

})

app.post('/admin/upload-videos', multer({
		dest: './files/videos/',
		rename: function (fieldname, filename, req, res){

			console.log('Song name is '+req.query.video_name)

			var video_name = req.query.video_name;

			// Date time
			var date = new Date();

			var day = dateFormat(date.request_date, "yyyy-mm-dd_h-MM-ss");

			var renamed_name = video_name + '_' + day;

			return renamed_name;
		},
		onFileUploadStart: function (file) {
		},
		onFileUploadData: function (file, data, req, res) {
		},
		onFileUploadComplete: function (file, req, res) {
			console.log('File uploaded');

			var video_id = randomValueHex(10);

			var video_name = JSON.parse(req.body.parameter).video_name;

			var album_name = JSON.parse(req.body.parameter).album_name;

			for(var i = 0; i < JSON.parse(req.body.parameter).singers.length; i++){

				var singer_name = JSON.parse(req.body.parameter).singers[i].name;

				var singer_id = JSON.parse(req.body.parameter).singers[i].id;				

				var singer_collection = song.Singers_In_Song({
					file_id: video_id,
					singer_id: singer_id
				})

				singer_collection.save(function(){})
			}

			var file_name = file.name;

			var file_url = file.path;

			var release_date = JSON.parse(req.body.parameter).release_date;

			var collection = song.Video({
				video_id: video_id,
				video_name: video_name,
				album_id: album_name.faid,
				video_file_name: file_name,
				video_file_url: file_url,
				release_date: release_date,
				added_on: new Date()
			})

			collection.save(function (err){
				if(err){
					res.send({
						status: false,
						message: 'Could not save to database'
					})
				}else{
					res.send({
						status: true,
						message: 'Video Saved in Database'
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

	app.get('/admin/get-fa-list', function (req, res){

		song.Featured_Album.find({}, function (err, data){
			if(err){
				res.send('Error while getting data')
			}else{
				res.send(data);
			}
		})

	})

	app.get('/admin/get-singer-list', function (req, res){

		song.Singer_Name.find({}, function (err, data){
			if(err){
				res.send('Error while getting data')
			}else{
				res.send(data);
			}
		})
		
	})


	app.post('/admin/test-file-upload', function (req, res){
		var fstream;
        req.pipe(req.busboy);
        req.busboy.on('file', function (fieldname, file, filename) {
        	console.log('fieldname is: '+fieldname)
            console.log("Uploading: " + filename);

            //Path where image will be uploaded
            fstream = fs_extra.createWriteStream('./test_folder/' + filename);
            file.pipe(fstream);
            fstream.on('close', function () {    
                console.log("Upload Finished of " + filename);              
                res.redirect('back');           //where to go next
            });
        });
	})

	app.post('/admin/upload-song', function (req, res){

		var fstream;
        req.pipe(req.busboy);
        req.busboy.on('file', function (fieldname, file, filename) {

        	var filetype = fieldname;

        	//if(filetype === "song file"){

        		console.log('Fieldname '+fieldname)

        		console.log("Uploading: " + filename);

	            //Path where image will be uploaded
	            fstream = fs_extra.createWriteStream('./files/songs/' + filename);
	            file.pipe(fstream);
	            fstream.on('close', function () {    
	                console.log("Upload Finished of " + filename);              
	                res.redirect('back');           //where to go next
	            });


				

        	

            
        });

	})


};
