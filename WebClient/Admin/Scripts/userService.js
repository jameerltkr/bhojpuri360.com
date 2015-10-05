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

.service('featuredAlbumService', function ($http, ENV, $q){
	this.getAlbums = function (parameter, file){
		var fd = new FormData();

		var d = $q.defer();

		fd.append('file', file);
		fd.append('parameter', parameter);

		var result = $http.post(ENV.baseUrl + '/upload-album?song_name=' + JSON.parse(parameter).song_name, fd, {
            transformRequest: angular.identity,
            headers: {'Content-Type': undefined}
        })
        .success(function(data){
          console.log('sssss')

          d.resolve(result);

          return data;
        })
        .error(function(err){
          console.log(err);
        });

        return d.promise;
	}

  this.getSingers = function(){
    return $http.get(ENV.baseUrl.substr(0,ENV.baseUrl.length-6) + "/web/get-singer-list"); 
  }
})


.service('singerService', function ($http, ENV, $q){
  this.addSinger = function (data){

    var d = $q.defer();

    var result = $http.post(ENV.baseUrl + '/add-singer', JSON.stringify({singer_name: data}))
        .success(function(data){
          console.log('sssss')
          
          d.resolve(result);

          return data;
        })
        .error(function(err){
          console.log(err);
        });

        return d.promise;
  }
})
