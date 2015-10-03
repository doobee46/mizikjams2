# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('.ui.primary.button').click ->
    $('.ui.modal').modal 'show'
    return
 return

$(document).ready ->
  $('.fa.fa-pencil-square-o').click ->
    $('.ui.modal').modal 'show'
    return
 return

$(document).ready ->
  $('a.ui.blue.button.manage').click ->
    $('#dash_box').hide()
    return
  return

$(document).ready ->
  $('table#cur_listing').DataTable()
  return
    