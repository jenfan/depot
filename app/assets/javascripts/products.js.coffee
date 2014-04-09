# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$('.windowClose').click ->
	  $('#predv_prosmotr').hide(100)
	$('#overlay').click ->
		$('#predv_prosmotr').hide(100)
		$('#overlay').hide(100)
	