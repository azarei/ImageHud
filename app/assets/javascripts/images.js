
$(document).ready(function() {
  $(".box_control").click(function() {
    $(this).parent().toggleClass("hide", 3000);
  });
  
  $("#level_1").click(function() {
    $("#searchResults").addClass("hide", 3000);
    $("#fileInfo").addClass("hide", 3000);
  });
  
  $("#level_2").click(function() {
    $("#searchResults").removeClass("hide", 3000);
    $("#fileInfo").removeClass("hide", 3000);
  });
})
