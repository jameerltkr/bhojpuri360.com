var app;
(function () {
    app = angular.module("songAppWeb", ['config', 'homeService']);
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