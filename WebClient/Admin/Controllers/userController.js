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

app.controller('fileUploadController', function ($scope, ENV, $http){
  $scope.add = function(){
  var f = document.getElementById('cover_photo').files[0],
      r = new FileReader(),
      song = document.getElementById('song').files[0],
      album_photo = document.getElementById('album_photo').files[0];
  //r.onloadend = function(e){
  //  var data = e.target.result;
    //send you binary data via $http or $resource or do anything else with it
  //}
  //r.readAsBinaryString(f);

  var parameter = JSON.stringify({song_name:$scope.song_name, 
        album_name:$scope.album_name});

  var coverfd = new FormData();
        coverfd.append('file', f);
        $http.post(ENV.baseUrl + '/upload-coverphoto?song_name=' + $scope.song_name, coverfd, {
            transformRequest: angular.identity,
            headers: {'Content-Type': undefined}
        })
        .success(function(){
          console.log('sssss')
        })
        .error(function(err){
          console.log(err);
        });

  var albumfd = new FormData();
        albumfd.append('file', album_photo);
        $http.post(ENV.baseUrl + '/upload-albumphoto?album_name=' + $scope.album_name, albumfd, {
            transformRequest: angular.identity,
            headers: {'Content-Type': undefined}
        })
        .success(function(){
          console.log('sssss')
        })
        .error(function(err){
          console.log(err);
        });

  var fd = new FormData();
        fd.append('file', song);
        fd.append('parameter', parameter);
        $http.post(ENV.baseUrl + '/upload-song?song_name=' + $scope.song_name, fd, {
            transformRequest: angular.identity,
            headers: {'Content-Type': undefined}
        })
        .success(function(){
          console.log('sssss')
        })
        .error(function(err){
          console.log(err);
        });

}
});

app.controller('featuredAlbumController', function ($scope, featuredAlbumService, $window){
  $scope.add = function(){
  var cover_photo = document.getElementById('cover_photo').files[0];

  var parameter = JSON.stringify({
      song_name:$scope.song_name, 
      album_name:$scope.album_name,
      singer_name: $scope.singer_name.name,
      singer_id: $scope.singer_name.singer_id
    });

  var albums = featuredAlbumService.getAlbums(parameter, cover_photo);

  albums.then(function(data){
    console.log(data);

    if(data.data.status == true){

      clearControls();

      $window.location.reload();

      alert(data.data.message);
    }else{
      alert(data.data.message);
    }

    //$scope.Albums = data;
  },function(err){
    alert(err);
  })


}

// fill filter singer dropdown

  var singers = featuredAlbumService.getSingers();

  singers.then(function (singer){
    $scope.Singers = singer.data;
  }, function (err){
    alert('Error while getting singer list');
  })
})

app.controller('singerController', function ($scope, singerService){

  $scope.AddSinger = function(){

    var singer_name = $scope.singer_name;

    singerService.addSinger(singer_name)
      .then(function (data){
        alert(data.data)
      })

  }

})

function clearControls(){
  $song_name = "";
  $album_name = "";
}