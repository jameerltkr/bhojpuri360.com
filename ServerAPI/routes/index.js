module.exports = function (app, socket) {
	app.get('/',function(req,res){
		res.send('Hello');
	});
};
