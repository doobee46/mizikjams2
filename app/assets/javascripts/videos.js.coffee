# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(".message.closable .close.icon").on "click", ->
    $('.message.closable').fadeOut("slow")
    false
    
$ ->
  $('.play a img').hover (->
    @src = @src.replace('_off', '_on')
    return
  ), ->
    @src = @src.replace('_on', '_off')
    return
  return

$ ->
  $('.index_play a img').hover (->
    @src = @src.replace('_off', '_on')
    return
  ), ->
    @src = @src.replace('_on', '_off')
    return
  return

$ ->
  $('.tile_play a img').hover (->
    @src = @src.replace('_off', '_on')
    return
  ), ->
    @src = @src.replace('_on', '_off')
    return
  return


$ ->
  $('.bxslider').bxSlider()
  auto: true,
  Controls: true
 return
