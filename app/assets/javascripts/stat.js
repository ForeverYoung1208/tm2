// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function(){
	$("#first_date").on('change', function(){
		var i=$(this).val()
		$("#first_date_xml").val(i)
	});

	$("#last_date").on('change', function(){
		var i=$(this).val()
		$("#last_date_xml").val(i)
	});

});