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
  $( ".hoverable").click(

    function () {
      var hoveredorderids = $(this).data('orderid')
      $(".hoverable").each(function(){
        var $i = $( this )
        try{
          $i.data('orderid').forEach(function(d){
            if ($.inArray(d, hoveredorderids ) != -1 ) {
              $i.toggleClass("highlighted");
            }
          })
        }
        catch(e){}
      })
    }

  )

//  .mouseleave( function(){
//    $( ".hoverable").removeClass("highlighted")
// })

});


$(document).ready(

  function(){
    setInterval(function(){
      $.get('/uporderstable')
    }, 30000);
  }
);
