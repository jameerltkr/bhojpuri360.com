var app;
(function () {
    app = angular.module("adminApp", ['config', 'userService']);
})();


app.controller('loginController', function ($scope, loginService, $window) {
	//$scope.IsNewRecord = 1; //The flag for the new record
 
    $scope.login = function(){
      console.log($scope.username);

      var data = 
      {
          username: $scope.username,
          password: $scope.password
      };

      var templogin = loginService.login(data); //The MEthod Call from service

      templogin.then(function (d) { 
        if(d.data.status === true && d.data.message === "Success"){
            $scope.loginstatus = "success";
            localStorage.username = d.data.username;
            $window.location.href = '/index.html';
          }else{
            $scope.loginstatus = "not success";
          }
      },
      function (errorPl) {
          $log.error('failure loading Employee', errorPl);
      });

    }
});

app.controller('logoutController', function ($scope, $window){
  $scope.logout = function(){
    localStorage.username = "";
    $window.location.href = '/login.html';
  }
})