// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require aorders
//= require stat


$(document).ready(

  function(){
    setInterval(function(){
      $.get('/uporderstable')
    }, 30000);
  }
);
