var siteModel = require('../app/db/model/site.js');

var featured_album = require('../app/db/model/song.js');

var singer_name_model = require('../app/db/model/song.js')

module.exports = function (app, socket) {
	

	app.get('/web/site-menu', function (req, res){
		siteModel.Menu.find({}, function (err, data){
			if(err){
				//alert('Error while loading menus');
				res.send('Error while loading menus');
			}else{
				res.send(data);
			}
		})
	})

	app.get('/web/get-albums', function (req,res){

		featured_album.Featured_Album.find({}).limit(2)
		.sort({date_added: 'desc'})
		.find({}, function (err, data){
			if(err){
				res.send('Error: '+err);
			}else{
				res.send(data);
			}
		})

		//res.send('Table not defined');

	})

	app.get('/web/get-singer-list', function (re, res){
		singer_name_model.Singer_Name.find({}, function (err, data){
			if(err){
				res.send('Error '+err)
			}else{
				res.send(data);
			}
		})
	})

	app.get('/web/get-album-details', function (req, res){

		console.log('Album name is: '+req.query.album_name);

	})


	


};
