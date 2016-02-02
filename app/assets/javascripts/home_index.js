$(document).ready(function() {
  fetchIdeas()
})

function fetchIdeas() {
  var newestItemId = parseInt($(".post").last().attr("data-id"))
  var ideaUri = 'http://localhost:3000/api/v1/ideas'

  $.getJSON(ideaUri, function(data) {
    $('#idea-info').html('');
    $.each(data, function (key, val) {
      var title = val.title;
      var body = val.body;
      var quality = val.quality;

      $('#idea-info').append('<h3>' + title + '</h3>' +
      '<p><strong>Summary: </strong>' + body + '</p>' +
      '<p><strong>Quality: </strong>' + quality + '</p>')
    })


  })
}
