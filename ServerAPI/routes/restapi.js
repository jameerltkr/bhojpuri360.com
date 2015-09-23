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



};


/*										*/
/*		End of API 						*/