$(document).ready(function(){

    $("#search").keyup(function(){
      keyword = $(this).val();

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
            newHTML.push('<h6><a href="/askrec/questions/tags/' + result.tags[i][0] + '">' + result.tags[i][0] + '</a><span class="new badge" data-badge-caption="">' + result.tags[i][1] + '</span></h6><br />');
          }
          $('.search_results').html(newHTML);
        },
      });
    });

});