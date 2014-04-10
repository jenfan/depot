# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$('.predv_close').click ->
	  $('#predv_prosmotr').hide(100)
	  $('#overlay').hide(100)
	$('#overlay').click ->
		$('#predv_prosmotr').hide(100)
		$('#overlay').hide(100)
	$('#addone').click ->
		$('#option_value_quantity').value = 2
	