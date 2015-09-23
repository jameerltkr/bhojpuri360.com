var app;
(function () {
    app = angular.module("crudModule", []);
})();


app.controller('crudController', function ($scope, testService) {
	//$scope.IsNewRecord = 1; //The flag for the new record
 
    loadRecords(); 
	//Function to load all Employee records
    function loadRecords() {
        var promiseGet = testService.getEmployees(); //The MEthod Call from service
 
        promiseGet.then(function (pl) { $scope.Employees = pl },
              function (errorPl) {
                  $log.error('failure loading Employee', errorPl);
              });
    }
    });


app.service('testService', function ($http) {
  //Get All Employees
    this.getEmployees = function () {
        return $http.get("http://www.localhost:3003/emp"); 
    }
    });