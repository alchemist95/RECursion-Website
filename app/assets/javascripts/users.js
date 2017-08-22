$(document).ready(function() {

	$("#nickname").keyup(function(){
			nickname = $(this).val();
			if(/^[a-zA-Z0-9_]*$/.test(nickname) == false || nickname.length < 4) {
    			$('#status').hide().html('<p>Nickname should be of length more than 4</p>').fadeIn("slow");
    			$(':input[type="submit"]').prop('disabled', true);
				return;
			}
			
			$.ajax({
				type: "POST",
				url: "/users/checknickname",
				data: {"nickname": nickname},
				success: function(result){
					if(result.status==='GoodToGo'){
						$(':input[type="submit"]').prop('disabled', false);
    					$('#status').hide().html('<p>Available</p>').fadeIn("slow");
					}
					else{
    					$('#status').hide().html('<p>Choose Another</p>').fadeIn("slow");
						$(':input[type="submit"]').prop('disabled', true);
					}
				},
			});
		});
});
