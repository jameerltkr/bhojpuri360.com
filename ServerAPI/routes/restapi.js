var path = require('path');
var mime = require('mime');
var fs = require('fs');
var music = require('../app/db/model/Music');

module.exports = function (app, socket) {


	app.get('/test',function(req,res){
		res.send('Welcome to web API');
	});
	app.get('/emp',function(req,res){
		//res.addHeader("Access-Control-Allow-Origin", "*");
		var response=[{
			EmployeeId:'1',
			FirstName:"Jameer",
			LastName:"Khan"
		},
		{
		EmployeeId:'2',
			FirstName:"jk",
			LastName:"jjj"	
		}]
		res.send(response);
	})

	app.get('/download', function(req, res) {
	  //res.setHeader('content-type', 'txt/plain');
	  //res.setHeader('content-disposition', 'attachment', 'filename:test/test.txt');
	  //return download.pipe(res); // assuming orders is a csv file readable stream (doesn't have to be a stream, can be a normal response)
	  var file ='./test/test.txt';

	  var filename = path.basename(file);
	  var mimetype = mime.lookup(file);

	  res.setHeader('Content-disposition', 'attachment; filename=' + filename);
	  res.setHeader('Content-type', mimetype);

	  var filestream = fs.createReadStream(file);
	  filestream.pipe(res);
	});
	app.get('/getimages', function (req,res){
		res.send([
		{
			id:'1',
			name:'My First Image',
			url:'img/1920/red.jpg'
		},
		{
			id:'2',
			name:'My Second Image',
			url:'img/1920/blue.jpg'
		}
		]);
	})
	app.get('/imgdescription', function (req, res){
		var id = req.param('id');
		console.log('Id received: ' + id);
		res.send('Found id ' + id + ' for the image');
	})
	app.get('/getmusic', function (req, res){
		music.Music.find({}, function(err, data){
			if(err)
				console.log('Error ' + err);
			else{
				console.log('Not error');
				res.send(data);
			}
		})
	})



};


/*										*/
/*		End of API 						*/