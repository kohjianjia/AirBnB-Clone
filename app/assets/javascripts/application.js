// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require rails-ujs
//= require activestorage
//= require_tree .

// this ensures that page loads completely
	// after loading, do the below
document.addEventListener("DOMContentLoaded", function(event){
	// when button is released, call backend server
	$('#title_search').on('keyup', function(e){
		$.ajax({
			url: '/listings/match',
			method: "POST",
			data: $(this).serialize(),
			dataType: 'json',
			success: function(data){
				console.log(data)
				var titles = document.getElementById("title_list")
				titles.innerHTML = ""

				data.forEach(function(listing){
					
					var option = document.createElement("option")
					option.value = listing.title
					titles.append(option);
				})
			}
		});
	})
	$('#city_search').on('keyup', function(e){
		// when button is released, call backend server

		$.ajax({
			url: '/listings/match',
			method: "POST",
			data: $(this).serialize(),
			dataType: 'json',
			success: function(data){
				console.log(data)
				var cities = document.getElementById("city_list")
				cities.innerHTML = ""

				data.forEach(function(listing){
					
					var option = document.createElement("option")
					option.value = listing.city
					cities.append(option);
				})
			}
		});
	})
})

