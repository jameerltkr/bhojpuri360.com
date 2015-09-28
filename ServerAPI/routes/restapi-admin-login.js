var user = require('../app/db/admin-model/user.js');

module.exports = function (app, socket) {

	app.post('/admin/login',function(req,res){
		console.log(req.body.username);

		var type = req.body.type;
		var username = req.body.username;
		var password = req.body.password;

		if(type === "admin"){
			console.log('Admin');

			user.User.findOne({
				username: username
			}, function (err, data){
				if(err){
					console.log('Error while admin login: ' + err);
				}else{
					if(data.password != password){
						console.log('Password mismatch!');
						res.send({
							status: false,
							message: 'Password mismatch'
						});
					}else{
						console.log('Admin logged in!!!');
						res.send({
							status: true,
							message: 'Success',
							username: username
						})
					}
				}
			})
		}

	});

};
