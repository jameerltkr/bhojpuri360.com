var siteModel = require('../app/db/model/site.js');

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


};
