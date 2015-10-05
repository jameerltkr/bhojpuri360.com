'use strict';

var testService = angular.module('homeService', [])

.service('menu', function ($http, ENV){
	//Get All Employees
    this.getMenus = function () {
      return $http.get(ENV.apiBaseUrl + "/site-menu"); 
    }
})

.service('albumService', function ($http, ENV){
	this.getAlbums = function(){
		return $http.get(ENV.apiBaseUrl + "/get-albums"); 
	}

	this.getSingers = function(){
		return $http.get(ENV.apiBaseUrl + "/get-singer-list"); 
	}
})

