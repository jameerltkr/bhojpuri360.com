var app;
(function () {
    app = angular.module("songAppWeb", ['config', 'detailsService']);
})();

app.controller('queryStringController', function ($scope, $location, getDetailsFromQS){
	
	if($location.$$absUrl.indexOf('details/get/song/') > -1)
	{
		var paramValue = $location.$$absUrl.substr($location.$$absUrl.lastIndexOf('/')+1, $location.$$absUrl.length)

		//alert(paramValue)

		getDetailsFromQS.getDetails(paramValue).then(function(data){
			$scope.Details = data;
		}, function(err){
			alert(err)
		})
	}

	
})