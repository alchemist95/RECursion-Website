 $(document).ready(function() {

	$("#search").keyup(function(){
      	keyword = $(this).val().toLowerCase();

	  	if( keyword.length < 1 || /^[\s]*$/.test(keyword) == true){
	        $('.search_results').html("");
	        return;
	    }

        $.ajax({
	        type: "POST",
	        url: "/find_users",
	        data: {"nickname": keyword},
	        success: function(result){
	          var newHTML = [];
	          for (var i = 0; i < result.users.length; i++) {
	          	console.log(result.users[i][0]);
	            newHTML.push('<a href="/users/profile/'+result.users[i][0]+'"><table class="highlight"><td><span style="line-height: 30px">'+result.users[i][0]+'(<i style="font-size: 10px">'+ result.users[i][1] + '</i>)</span><span style="float:right"><img class="circle" src="' + result.users[i][2] + '" alt="Photo" width="40" height="40" ></span></td></table></% end /%>');
	          }
	          $('.search_results').html(newHTML);
	        },
      	});
    });
    
});
