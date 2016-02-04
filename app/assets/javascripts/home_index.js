$(document).ready(function() {
  fetchIdeas()
  createIdea()
  deleteIdea()
  increaseQuality()
  decreaseQuality()
  updateTitle()
  updateBody()
  ideaFilter()
})

function renderIdea(idea) {
  $("#idea-info").prepend(
    "<div class='idea' data-id='" + idea.id + "' data-quality='" + idea.quality +
    "' data-title='" + idea.title + "' data-body='" + idea.body +
    "'><span class='title-span'><h3 contentEditable='true' class='idea-title'>" + idea.title + "</h3></span>" +
    "<span><strong>Summary: </strong></span><p contentEditable='true' class='idea-summary'>" + truncateBody(idea.body) + "</p>" +
    "<button class='save' name='save-button' class=''>Save</button>" +
    "<div><p class='idea-quality'><strong>Quality: </strong>" + idea.quality + "</p>" +
    "<button class='increase-idea' name='increase-button' class=''> + </button>" +
    "<button class='decrease-idea' name='decrease-button' class=''> - </button></div>" +
    "<button class='edit-idea' name='edit-button' class=''>Edit</button>" +
    "<button class='delete-idea' name='delete-button' class=''>Delete</button></div></div>"
  )
}

function fetchIdeas() {
  var ideaUri = '/api/v1/ideas'

  $.getJSON(ideaUri, function(data) {
    $('#idea-info').html('');
    $.each(data, function(key, val) {
      renderIdea(val)
    })
    editButton()
  })
}

function truncateBody(body) {
  if (body == null) {
    return body
  }
  else if (body.length > 100) {
    var hundredWords = body.slice(0,100)
    var lastWord = body.slice(100).split(" ")[0]
    return hundredWords + lastWord + '...'
  }
  else {
    return body
  }
}

function createIdea() {
  $("#create-idea").on("click", function() {
    var ideaParams = {
        title: $("#idea-title").val(),
        body: $("#idea-body").val()
    };

    $.ajax({
      type:    "POST",
      url:     "/api/v1/ideas",
      data:    ideaParams,
      success: function(newIdea) {
        renderIdea(newIdea)
      },
      error: function(xhr) {
        console.log(xhr.responseText)
      }
    })
    document.getElementById('idea-title').value = ""
    document.getElementById('idea-body').value = ""

  })
}

function deleteIdea() {
  $("#idea-info").delegate(".delete-idea", "click", function() {
    var $idea = $(this).closest(".idea")

    $.ajax({
      type: 'DELETE',
      url: "/api/v1/ideas/" + $idea.attr('data-id') + "",
      success: function() {
        $idea.remove()
      },
      error: function(xhr) {
        console.log(xhr.responseText)
      }
    })
  })
}

function increaseQuality() {
  $('#idea-info').delegate('.increase-idea', 'click', function() {
    var $idea = $(this).closest(".idea")
    var quality = $idea.attr('data-quality')
    var nextQuality = {
      swill: "plausible",
      plausible: "genius",
      genius: "genius"
    }
    var ideaParams = {
      quality: nextQuality[quality]
    };

    $.ajax({
      type: 'PUT',
      url: "/api/v1/ideas/" + $idea.attr('data-id') + "",
      data:    ideaParams,
      success: function(updatedIdea) {
        updateQuality($idea, updatedIdea.quality)
      },
      error: function(xhr) {
        console.log(xhr.responseText)
      }
    })
  })
}

function decreaseQuality() {
  $('#idea-info').delegate('.decrease-idea', 'click', function() {
    var $idea = $(this).closest(".idea")
    var quality = $idea.attr('data-quality')
    var nextQuality = {
      genius: "plausible",
      plausible: "swill",
      swill: "swill"
    }
    var ideaParams = {
      quality: nextQuality[quality]
    };

    $.ajax({
      type: 'PUT',
      url: "/api/v1/ideas/" + $idea.attr('data-id') + "",
      data:    ideaParams,
      success: function(updatedIdea) {
        updateQuality($idea, updatedIdea.quality)
      },
      error: function(xhr) {
        console.log(xhr.responseText)
      }
    })
  })
}

function updateQuality(idea, quality){
  $(idea).find('.idea-quality').html('<strong>Quality: </strong>' + quality);
  $(idea).attr('data-quality', quality);
}

function updateTitle() {
  $('#idea-info').delegate('.idea-title', 'keyup', function (event) {
    if(event.keyCode == 13) {
      event.preventDefault();
      var $idea = $(this).closest('.idea')
      var $updatedTitle = event.currentTarget.textContent
      var ideaParams = {
        title: $updatedTitle
      }
      sendPut($idea, ideaParams, event)
    }
  })
}

function sendPut(idea, data, event) {
  $.ajax({
    type: 'PUT',
    url: "/api/v1/ideas/" + idea.attr('data-id') + "",
    data: data,
    success: function(updatedIdea) {
      if (event != null) {
        $(event.target).blur()
      }
      replaceTitle(idea, updatedIdea.title);
    },
    error: function(xhr) {
      console.log("A title is required for your idea.")
    }
  })
}

function replaceTitle(idea, title) {
  $(idea).find('.idea-title').html(title)
}

function updateBody() {
  $('#idea-info').delegate('.idea-summary', 'keyup', function (event) {
    if(event.keyCode == 13) {
      event.preventDefault();
      var $updatedBody = event.currentTarget.textContent
      var $idea = $(this).closest('.idea')
      var ideaParams = {
        body: $updatedBody
      }
      sendPut($idea, ideaParams, event)
    }
  })
}

function replaceBody(idea, body) {
  $(idea).find('.idea-summary').html(body)
}

function ideaFilter () {
  $('#idea_filter_title').keyup('change', function () {
    var currentIdea = this.value
    $('.idea').each(function (index, idea) {
      $idea = $(idea);
      $ideaTitle = $(idea).data('title')
      $ideaBody = $(idea).data('body')
      if ($ideaTitle.includes(currentIdea) || $ideaBody.includes(currentIdea)) {
        $idea.show()
      } else {
        $idea.hide()
      }
    })
  })
}

function editButton() {
  $('.edit-idea').click(function() {
    var $idea = $(this).closest('.idea')
    $idea.addClass('editing')
  })
  $('.save').click(function() {
    var $idea = $(this).closest('.idea')
    $idea.removeClass('editing')
    var updatedTitle = $idea.find('.idea-title').text()
    var updatedBody = $idea.find('.idea-summary').text()
    var ideaParams = {
      title: updatedTitle,
      body: updatedBody
    }
    sendPut($idea, ideaParams)
  })
}
