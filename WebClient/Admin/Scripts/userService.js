'use strict';

var userService = angular.module('userService', [])

.service('loginService', function ($http, ENV, $q){
	//Get All Employees
    this.login = function (data) {

    	var d = $q.defer();

    	var parameter = JSON.stringify({type:"admin", username:data.username, 
    		password:data.password});

      console.log(data);

      var result = $http.post(ENV.baseUrl + '/login', parameter).
	    	success(function(data, status, headers, config) {
	        	// this callback will be called asynchronously
	        	// when the response is available
	        	console.log(data);
	        	d.resolve(result);
	      	}).
	      	error(function(data, status, headers, config) {
	        // called asynchronously if an error occurs
	        // or server returns response with an error status.
	      	});

      return d.promise;
    }

})

