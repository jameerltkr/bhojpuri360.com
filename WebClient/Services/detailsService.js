'use strict';

var detailsService = angular.module('detailsService', [])

.service('getDetailsFromQS', function ($http, ENV){
	this.getDetails = function(data){
		return $http.get(ENV.apiBaseUrl + "/get-album-details?album_name="+data); 
	}
})