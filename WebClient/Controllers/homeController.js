var app;
(function () {
    app = angular.module("songAppWeb", ['config', 'homeService', 'homeFilter']);
})();


app.controller('titleController', function ($scope, ENV) {
	//$scope.IsNewRecord = 1; //The flag for the new record
 
  $scope.title = ENV.title;   
});

app.controller('menuController', function ($scope, menu, ENV){
  var menu = menu.getMenus();

  menu.then(function (menuitems){
    $scope.MenuItems = menuitems.data;
  }, function(err){
    alert('Error while loading menus');
  })
})

app.controller('albumController', function ($scope, ENV, albumService, $filter){

	var albums = albumService.getAlbums();

	albums.then(function (album){

		if(album.data.length >= 2)
			$scope.loadmorealbum = true;

		$scope.baseUrl = ENV.apiBaseUrl;
		$scope.Albums = album.data;
		$scope.date = new Date();


		//$scope.quantity = 2;
		
	},function(err){
		alert('Error while getting album list');
	})

	$scope.filterByDateChange = function(){

		console.log($scope.filterByDate);

		$scope.filteringDate = $scope.filterByDate;

		$scope.Albums = $filter('filterByDate')($scope.Albums, $scope.filteringDate);
	}

	// fill filter singer dropdown

	var singers = albumService.getSingers();

	singers.then(function (singer){
		$scope.Singers = singer.data;
	}, function (err){
		alert('Error while getting singer list');
	})

})