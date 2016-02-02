$(document).ready(function) {
  fetchIdeas
}

function fetchIdeas() {
  var ideaUri = 'http://localhost:3000/api/v1/ideas'

  $.getJSON(ideaUri, function(data) {
    $('idea-info').html('');
    $.each(data.results, function (key, val) {
      debugger
      var title = data.title;
      var body = data.body;
      var quality = data.quality;
    })

    // $('idea-info').append('<h3>' + title + '</h3>' +
    // '<p><strong>Summary: </strong>' + + '</p>' +
    // '<p><strong>Quality: </strong>' + + '</p>')
  })
}
