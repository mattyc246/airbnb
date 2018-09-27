var filter_call = function(key,v){

		var attribute = key
		
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

	$('.search-city').keyup(function(){

		var attribute = "search"

		var value = this.value

		var json = {}

		json[attribute] = value

		$.ajax({
			url: "/listings/search",
			method: "GET",
			data: json,
			success: function(){
				$('.dropdown-item').click(function(e){
					e.preventDefault();
					$("#city")[0].value = (e.target.innerHTML);
					$("#autofill-list").removeClass('show');

				})
			}
		});



	});

	// $(".dropdown-item").click(function(event){
	// 	event.preventDefault();
	// 	console.log(this)
	// 	$(".search-city").text(this.text);

	// })



	});