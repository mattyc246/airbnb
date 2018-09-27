var filter_call = function(key,v){

		var attribute = key
		// console.log(attribute)
		var value = v 

		var json = {}

		json[attribute] = value

		console.log(json)

		$.ajax({
			url: "/listings/filter",
			method: "GET",
			data: json
		});
	};

$(document).ready(function(){

	$(".filter-choice").change(function(){
		filter_call(this.name, this.value)});

	$(".filter-choice-form").submit(function(e){
		e.preventDefault();
		filter_call(this[1].name, this[1].value)});

	$('.dropdown-toggle').dropdown();

	$('.search-city').change(function(){

		var attribute = this.name

		var value = this.value

		json[attribute] = value

		$.ajax({
			url: "/listings/search",
			method: "GET",
			data: json
		});


	})

	});