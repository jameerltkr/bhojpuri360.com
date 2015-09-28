var app;
(function () {
    app = angular.module("crudModule", ['config', 'testService']);
})();


app.controller('crudController', function ($scope, tests) {
	//$scope.IsNewRecord = 1; //The flag for the new record
 
    loadRecords(); 
	//Function to load all Employee records
    function loadRecords() {
        var promiseGet = tests.getEmployees(); //The MEthod Call from service
 
        promiseGet.then(function (pl) { $scope.Employees = pl },
              function (errorPl) {
                  $log.error('failure loading Employee', errorPl);
              });
    }

    

    });

  app.controller('downloadController', function ($scope, $http, ENV){
    $scope.download = function(){
      $http.get(ENV.baseUrl + '/download').
      success(function(data, status, headers, config) {
         var anchor = angular.element('<a/>');
         anchor.attr({
             href: 'data:attachment;charset=utf-8,' + encodeURI(data),
             target: '_blank',
             download: 'test.txt'
         })[0].click();

      }).
      error(function(data, status, headers, config) {
        // if there's an error you should see it here
      });
    }
  })

  app.controller('imageController', function ($scope, imageService, ENV){
    console.log('App Name is: ' + ENV.App_Name);
   // getImages();
    //function getImages(){
      var images = imageService.getImages();
      images.then(function(img){
        $scope.Images = img.data;
        $scope.appPath = ENV.baseUrl;
        console.log(img.data);
      },function (error){
        console.log('Failure loading images' + error);
      })
    //}

  })

  app.controller('musicController', function ($scope, musicService, ENV){
    var music = musicService.getMusic();
    music.then(function(music){
      $scope.Music = music.data;
      $scope.appPath = ENV.baseUrl;
      console.log(music);
    },function(error){
      console.log(error);
    })
  })


app.service('imageService', function ($http, ENV){
  this.getImages = function(){
    return $http.get(ENV.baseUrl + "/getimages"); 
  }
})