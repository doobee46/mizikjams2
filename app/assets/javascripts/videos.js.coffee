# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(".message.closable .close.icon").on "click", ->
    $('.message.closable').fadeOut("slow")
    false
    
$ ->
  $('.play img').hover (->
    @src = @src.replace('_off', '_on')
    return
  ), ->
    @src = @src.replace('_on', '_off')
    return
  return


$(document).ready ->
  $('.bxslider').bxSlider()
  auto: true,
  autoControls: true
  return
