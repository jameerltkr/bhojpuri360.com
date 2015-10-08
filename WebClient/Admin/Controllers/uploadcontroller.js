var app;
(function () {
    app = angular.module("adminApp", ['config', 'uploadservice']);
})();

app.controller('FAController', function ($scope, ENV, FAService){

	$scope.parent = {release_date: ''};

	var singers = [];

	var index = 0;

	$scope.add_items_to_list = function(){

		index = index + 1;

		singers.push({
			id: index,
			name: $scope.add_singer
		})

		//alert(singer_list.name);

		singers.join(', ')

		$scope.singer_list = singers;

		$scope.add_singer = "";

	}

	$scope.add_fa = function(){

		var cover_photo = document.getElementById('cover_photo').files[0];

		var album_name = $scope.album_name;

		var release_date = $scope.parent.release_date

		var singer_list = $scope.singer_list;

		var parameter = JSON.stringify({
			album_name: album_name,
			release_date: release_date,
        	singer_list: singer_list
    	});

    	var result = FAService.uploadData(parameter, cover_photo);

    	result.then(function (data){
    		if(data.data.status == true){

    			alert(data.data.message);

    			$scope.album_name = "";

    			$scope.parent.release_date = "";

    			$scope.singer_list = "";

    			$("#cover_photo").val('')

    			singers = [];

    		}
    	})

		console.log('ddd')

	}





})


app.controller('singerController', function ($scope, singerService){

	$scope.AddSinger = function(){

	    var singer_name = $scope.singer_name;

	    singerService.addSinger(singer_name)
	      .then(function (data){

	        alert(data.data)

	        $scope.singer_name = "";

	      })

  	}

})

app.controller('songController', function ($scope, videosService){

	var singers_list = [];

	var index = 0;

	var albums = videosService.getAlbums();

	albums.then(function (data){
		$scope.video_album_list = data.data;
		$scope.Albums = data.data;
	}, function (err){
		alert(err)
	})

	var singers = videosService.getSingers();

	singers.then(function (data){
		//$scope.video_singer_list_span = data.data;
		$scope.Singers = data.data;
	}, function (err){
		alert(err)
	})


	$scope.select_singers = function(){

		var singer_name = $scope.singer_list;

		index = index + 1;

		var exist = false;

		for(var i = 0; i < singers_list.length; i++){

			if (singers_list[i].id.indexOf(singer_name.singer_id) > -1)

				exist = true;
		}

		if(!exist && singers_list.length != 0){
			singers_list.push({
					id: singer_name.singer_id,
					name: singer_name.name
				})
		}

		if(singers_list.length == 0){
			singers_list.push({
					id: singer_name.singer_id,
					name: singer_name.name
				})
		}

		
		$scope.singer_list_show = singers_list;

		$scope.video_singer_list_span = singers_list;

	}


	$scope.addSong = function(){

		var song_name = $scope.song_name;

		var release_date = $scope.parent.release_date;

		var album_name = $scope.video_album_list;

		var singers = $scope.video_singer_list_span;

		var song_file = document.getElementById('song_file').files[0];

		var song_cover_file = document.getElementById('song_cover_photo').files[0];		

		var parameter = JSON.stringify({
			song_name: song_name,
			album_name: album_name,
        	singers: singers,
        	release_date: release_date
    	});

    	var upload_song = videosService.uploadSong();

    	upload_song.then(function (data){
    		alert(data.data.message)

    		$scope.song_name = "";

    		$scope.parent.release_date = "";

    		$scope.video_album_list = "";

    		$scope.video_singer_list_span = "";

    		$("#song_file").val('')

    		$("#song_cover_photo").val('')
    	})

		singers_list = [];

	}

})

app.controller('videoController', function ($scope, videosService){

	var singers_list = [];

	var index = 0;

	var albums = videosService.getAlbums();

	albums.then(function (data){
		$scope.video_album_list = data.data;
		$scope.Albums = data.data;
	}, function (err){
		alert(err)
	})

	var singers = videosService.getSingers();

	singers.then(function (data){
		//$scope.video_singer_list_span = data.data;
		$scope.Singers = data.data;
	}, function (err){
		alert(err)
	})


	$scope.select_singers = function(){

		var singer_name = $scope.singer_list;

		index = index + 1;

		var exist = false;

		for(var i = 0; i < singers_list.length; i++){

			if (singers_list[i].id.indexOf(singer_name.singer_id) > -1)

				exist = true;
		}

		if(!exist && singers_list.length != 0){
			singers_list.push({
					id: singer_name.singer_id,
					name: singer_name.name
				})
		}

		if(singers_list.length == 0){
			singers_list.push({
					id: singer_name.singer_id,
					name: singer_name.name
				})
		}

		
		$scope.singer_list_show = singers_list;

		$scope.video_singer_list_span = singers_list;

	}

	$scope.add_videos = function(){

		var video_name = $scope.video_name;

		var album_name = $scope.video_album_list;

		var singers = $scope.video_singer_list_span;

		var video_song_file = document.getElementById('video_file').files[0];

		var release_date = $scope.parent.release_date;

		var parameter = JSON.stringify({
			video_name: video_name,
			album_name: album_name,
        	singers: singers,
        	release_date: release_date
    	});

		var upload_video = videosService.addVideo(video_song_file, parameter);

		upload_video.then(function (data){
			alert(data.data.message)

			$scope.video_name = "";

			$scope.video_album_list = "";

			$scope.video_singer_list_span = "";

			$("#video_file").val('')

			$scope.parent.release_date = "";
		})		


		singers_list = [];
	}

})