'use strict';

var testService = angular.module('testService', [])

.service('tests', function ($http, ENV){
	//Get All Employees
    this.getEmployees = function () {
      return $http.get(ENV.baseUrl + "/emp"); 
    }
})
.service('musicService', function ($http, ENV){
	this.getMusic = function(){
		return $http.get(ENV.baseUrl + "/getmusic"); 
	}
})
