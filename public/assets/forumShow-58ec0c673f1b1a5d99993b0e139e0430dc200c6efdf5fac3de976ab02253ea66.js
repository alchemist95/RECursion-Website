$(document).ready(function(){

	//console.log("Hi from forumShow.js");

	$("#answerForm").hide();
	$('#commentButton').prop('disabled', true);

	$("#commentForm").keyup(function() {
		var comment = $(this).val();
		var id = $(".question_id").attr("id");

		if( comment.length > 140){
			$('#commentStatus').hide().html('<p>A comment can be of 140 letters at max</p>').fadeIn("slow");
			$('#commentButton').prop('disabled', true);
			return;
		}
		else if( comment.length < 1 || /^[\s]*$/.test(comment) == true){
			$('#commentButton').prop('disabled', true);
			return;
		}
		else{
			$('#commentButton').prop('disabled', false);
			return;
		}

	});


	$("#commentButton").click(function(){
		
		var comment = $("#commentForm").val();
		console.log(comment);
		var id = $(".question_id").attr("id");

		$.ajax({
	 		type: 'POST',
	 		url: '/askrec/questions/'+id+'/comment',
			data: {"body": comment},
	 		success: function(){
	 			console.log("Done!!");

			 	var newComment = '<div class="comment"><div class="row"><div class="col s12"><b>You</b><b style="float: right;">Now</b></div><div class="col s12"><p style="word-wrap: break-word;">'+comment+'</p></div></div><div class="divider"></div></div></div>';
			
			 	var div = document.getElementById('commentSection');
			 	div.innerHTML = newComment + div.innerHTML;
			 	$('#no-comment-message').html("");
			},
	 		error: function(){
	 			alert("Failure!");
	 		}
	 	});
	 	$("#commentForm").val("");
	 	$('#commentButton').prop('disabled', true);
	});


	$("#showAnswerForm").click(function() {
		$("#answerForm").show();
		$("#showAnswerForm").prop('disabled', true);
	});

	
	$("#followButton").click(function() {
		event.preventDefault();
		var id = $(".question_id").attr("id");
		var count = parseInt($(".follow_count").text());
		var status = $(".follow_status").attr("id");
		$.ajax({
			type: 'GET',
			url: '/askrec/questions/'+id+'/follow',
			dataType:  "json",
			success: function(){
				if(status === 'false'){
					$(".follow_status").attr('id', 'true');
					$("#followButton").html('Unfollow');
					count++;
				}
				else{
					$(".follow_status").attr('id', 'false');
					$("#followButton").html('Follow');	
					count--;
				}
				$(".follow_count").html(count+' Followers');
			},
	 		error: function(){
	 			alert("Failure!");
	 		}
		})

	});

	$(".upvoteAnswer").click(function() {
		event.preventDefault();
		var id = $(this).attr("id");
		console.log(id);
		var answerId = parseInt(id.match(/\d+/)[0]);
		console.log(answerId);
	 	var status = $(".upvote_status-"+id).attr("id");
		console.log(status);

		var count = parseInt($(".upvote_count-"+id).text())
		console.log(count);

	 	$.ajax({
	 		type: 'POST',
	 		url: '/upvoteAnswer',
	 		data: {"id": answerId},
	 		success: function(){

	 			if(status === 'false'){
	 				count++;
	 				console.log("Hello");
	 				$(".upvote_status-"+id).attr('id', 'true');
	 				$("#"+id).html('Downvote');
	 			}
	 			else{
	 				count--;
	 				console.log("Bol");
	 				$(".upvote_status-"+id).attr('id', 'false');
	 				$("#"+id).html('Upvote');
	 			}

				$(".upvote_count-"+id).html(count+' Upvotes');
			},
	 		error: function(){
	 			alert("Failure!");
	 		}
	 	})

	});

});
