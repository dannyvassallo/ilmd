# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

fbs_click = (width, height) ->
  leftPosition = undefined
  topPosition = undefined
  
  #Allow for borders.
  leftPosition = (window.screen.width / 2) - ((width / 2) + 10)
  
  #Allow for title and status bars.
  topPosition = (window.screen.height / 2) - ((height / 2) + 50)
  windowFeatures = "status=no,height=" + height + ",width=" + width + ",resizable=yes,left=" + leftPosition + ",top=" + topPosition + ",screenX=" + leftPosition + ",screenY=" + topPosition + ",toolbar=no,menubar=no,scrollbars=no,location=no,directories=no"
  u = location.href
  t = document.title
  window.open "http://www.facebook.com/sharer.php?u=" + encodeURIComponent(u) + "&t=" + encodeURIComponent(t), "sharer", windowFeatures
  false
