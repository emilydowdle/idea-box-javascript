$(document).ready(function() {
  fetchIdeas()
  createIdea()
  deleteIdea()
})

function renderIdea(idea) {
  $("#idea-info").append(
    "<div class='idea' data-id='" + idea.id +
    "'><h3>" + idea.id + idea.title + "</h3>" +
    "<p><strong>Summary: </strong>" + idea.body + "</p>" +
    "<p><strong>Quality: </strong>" + idea.quality + "</p>" +
    "<button id='delete-idea' name='delete-button' class=''>Delete</button></div>"
  )
}
//       var title = val.title;
      // var body = val.body;
      // var quality = val.quality;
      //


function fetchIdeas() {
  var newestItemId = parseInt($(".idea").last().attr("data-id"))
  var ideaUri = 'http://localhost:3000/api/v1/ideas'

  $.getJSON(ideaUri, function(data) {
    $('#idea-info').html('');
    $.each(data, function(key, val) {
      if (isNaN(newestItemId) || val.id > newestItemId) {
        renderIdea(val)
      }
    })
  })
}


function createIdea() {
  $("#create-idea").on("click", function() {
    var ideaParams = {
        title: $("#idea-title").val(),
        body: $("#idea-body").val()
    };

    $.ajax({
      type:    "POST",
      url:     "http://localhost:3000/api/v1/ideas",
      data:    ideaParams,
      success: function(newIdea) {
        console.log(newIdea)
        renderIdea(newIdea)
      },
      error: function(xhr) {
        console.log(xhr.responseText)
      }
    })
  })
}
