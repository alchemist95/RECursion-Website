$(document).ready(function() {
	$("#nickname").keyup(function(){
			nickname = $(this).val();
			if(/^[a-zA-Z0-9_]*$/.test(nickname) == false || nickname.length < 4) {
    			$('#status').hide().html('Username (Minimum 4 letters and no special characters)').fadeIn("slow");
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
    					$('#status').hide().html('Username (Available)').fadeIn("slow");
					}
					else{
    					$('#status').hide().html('Username (Not Available)').fadeIn("slow");
						$(':input[type="submit"]').prop('disabled', true);
					}
				},
			});
		});
});
