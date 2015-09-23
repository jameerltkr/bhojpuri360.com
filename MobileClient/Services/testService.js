/// <reference path="../angular.js" />
var app;
(function () {
    app = angular.module("crudModule", []);
})();

app.service('testService', function ($http) {
	//Get All Employees
    this.getEmployees = function () {
        return $http.get("http://www.localhost:3003/emp"); 
    }
    });