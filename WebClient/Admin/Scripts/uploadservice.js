'use strict';

var uploadservice = angular.module('uploadservice', [])

.service('FAService', function ($http, ENV, $q){

	this.uploadData = function(parameter, file){

		var fd = new FormData();

		var d = $q.defer();

		fd.append('file', file);
		fd.append('parameter', parameter);

		var result = $http.post(ENV.baseUrl + '/upload-album?album_name=' + JSON.parse(parameter).album_name, fd, {
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

.service('videosService', function ($http, ENV, $q){
	
	this.getAlbums = function(){
		return $http.get(ENV.baseUrl + "/get-fa-list"); 
	}

	this.getSingers = function(){
		return $http.get(ENV.baseUrl + "/get-singer-list"); 
	}


	this.addVideo = function (file, parameter){

    var fd = new FormData();

		var d = $q.defer();

		fd.append('file', file);
		fd.append('parameter', parameter);

		var result = $http.post(ENV.baseUrl + '/upload-videos?video_name=' + JSON.parse(parameter).video_name, fd, {
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

  this.uploadSong = function(song_file, cover_file, parameter){

  		var fd = new FormData();

		var d = $q.defer();

		fd.append('song file', song_file);
		fd.append('song cover', cover_file);
		fd.append('parameter', parameter);

		var result = $http.post(ENV.baseUrl + '/upload-song', fd, {
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

})