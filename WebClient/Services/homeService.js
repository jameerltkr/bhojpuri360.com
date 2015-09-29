'use strict';

var testService = angular.module('homeService', [])

.service('menu', function ($http, ENV){
	//Get All Employees
    this.getMenus = function () {
      return $http.get(ENV.apiBaseUrl + "/site-menu"); 
    }
})
