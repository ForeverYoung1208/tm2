// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


//Для того, чтобы возврат обрабатывался как яваскриптскипт
//

$.ajaxSetup({
  dataType: "script"
});

// сработало и без этого
//$(function() {
//  $('a.remote').attach(Remote.Link);
//  $('form.remote').attach(Remote.Form);
//});

// конфигурируем календарь
$(function() {
  $( "#tek_date" ).datepicker({dateFormat: 'yy-mm-dd'});
  $( "#tek_date" ).datepicker( "option", "firstDay", 1 );
  $( "#tek_date" ).datepicker( "option", "monthNames", ['Январь','Февраль','Март','Апрель','Май','Июнь','Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь'] );
  $( "#tek_date" ).datepicker( "option", "dayNamesMin", ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб'] );
  $( "#tek_date" ).datepicker({
      onSelect:function(){ $.get('/orders') }
  })
});

//$(document).ready(
//      function(){
//                  setInterval(function(){
//                     $('table.allorderlist').hide();
//                  }, 5000);
//                });

//
$(document).ready(
      function(){
                  setInterval(function(){
                     $.get('/uporderstable')
                  }, 30000);
                });
