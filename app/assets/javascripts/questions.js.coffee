# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->

  $('#new-category').hide()

  $('.radio').click ->
    if $('#category_').prop('checked') == true
      $('#new-category').show()
    else
      $('#new-category').hide()
      $('.new-category').val("")


