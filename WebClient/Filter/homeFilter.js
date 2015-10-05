var homeFilter = angular.module('homeFilter', [])

.filter('filterByDate', function(){

	return function(albums, filteringDate){

		if(!angular.isDefined(filteringDate) || filteringDate == '' || filteringDate == null){
   			return albums;
  		}

		var filteringTime = "";

		if(filteringDate != undefined){
													// month*day*hour*minute*second*ms
			if(filteringDate === "Between 1 month")
				filteringTime = new Date().getTime() - 1*30*24*60*60*1000;

			if(filteringDate === "Between 3 month")
				filteringTime = new Date().getTime() - 3*30*24*60*60*1000;

			if(filteringDate === "Between 6 month")
				filteringTime = new Date().getTime() - 6*30*24*60*60*1000;

			if(filteringDate === "Between 1 year")
				filteringTime = new Date().getTime() - 12*30*24*60*60*1000;

			if(filteringDate === "more than 1 year")
				filteringTime = new Date().getTime() - 52*30*24*60*60*1000;
		}

		var filtered_list = [];

		if(filteringTime != "")

			for (var i = 0; i < albums.length; i++) {

				var last_modified = new Date(albums[i].date_added).getTime();

				if (filteringTime <= last_modified) {
	        		filtered_list.push(albums[i]);
	      		}
			}

		return filtered_list;
	};

})

.filter('filterBySingerName', function(){
	return function(albums, singer_id){

		if(!angular.isDefined(singer_id) || singer_id == '' || singer_id == null){
   			return albums;
  		}

  		var filtered_list = [];

  		for (var i = 0; i < albums.length; i++) {

  			if(singer_id.singer_id === albums[i].singer_id)
  				filtered_list.push(albums[i]);

  		}
  		return filtered_list;
  	}
  	
})

