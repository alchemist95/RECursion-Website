$(document).ready(function(){
    //console.log("Hi from forum.js");

    $("#search").keyup(function(){
      keyword = $(this).val().toLowerCase();

      if( keyword.length < 1 || /^[\s]*$/.test(keyword) == true){
        $('.search_results').html("");
        return;
      }

      $.ajax({
        type: "POST",
        url: "/find_questions",
        data: {"keyword": keyword},
        success: function(result){
          var newHTML = [];
          for (var i = 0; i < result.tags.length; i++) {
            newHTML.push('<h6><a href="/askrec/questions/tags/' + result.tags[i][0] + '"><table class="highlight"><td><span>'+ result.tags[i][0] + '</a><span class="new badge" data-badge-caption="">' + result.tags[i][1] + '</span></td></table></h6><br />');
          }
          $('.search_results').html(newHTML);
        },
      });
    });

});