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

// конфигурируем календари
$(function() {
  $( "#tek_date" ).datepicker({dateFormat: 'yy-mm-dd'});
  $( "#tek_date" ).datepicker( "option", "firstDay", 1 );
  $( "#tek_date" ).datepicker( "option", "monthNames", ['Январь','Февраль','Март','Апрель','Май','Июнь','Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь'] );
  $( "#tek_date" ).datepicker( "option", "dayNamesMin", ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб'] );
  $( "#tek_date" ).datepicker({
      onSelect:function(){ $.get('/orders') }
  })
});

$(function() {
  $( "#first_date" ).datepicker({dateFormat: 'yy-mm-dd'});
  $( "#first_date" ).datepicker( "option", "firstDay", 1 );
  $( "#first_date" ).datepicker( "option", "monthNames", ['Январь','Февраль','Март','Апрель','Май','Июнь','Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь'] );
  $( "#first_date" ).datepicker( "option", "dayNamesMin", ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб'] );
});

$(function() {
  $( "#last_date" ).datepicker({dateFormat: 'yy-mm-dd'});
  $( "#last_date" ).datepicker( "option", "firstDay", 1 );
  $( "#last_date" ).datepicker( "option", "monthNames", ['Январь','Февраль','Март','Апрель','Май','Июнь','Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь'] );
  $( "#last_date" ).datepicker( "option", "dayNamesMin", ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб'] );
});


$(function() {
  $( ".hoverable").hover(
    function () {

      var currorderids = $(this).data('orderid')
//      alert(orderids[0])
      $("td:data(orderid)").each(function(){
        $( this ).addClass("highlighted");
      })


//      $(this).addClass("highlighted");
    },
    function () {
      $("td:data(orderid)").each(function(){
        $( this ).removeClass("highlighted");
      })


//      $(this).removeClass("highlighted");
    }
  )
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
                  }, 300000);
                });
