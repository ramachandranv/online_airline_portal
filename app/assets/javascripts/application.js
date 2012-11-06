// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .

var personTemplate = $("<div class='control-group'>Name: <input type='text' name='name'>Age: <input type='text' name='age'></div>");
$(document).ready(function() {
  $('#enquiry_number_of_persons').blur(function(){
    $('.passenger_details_container .control-group').remove();
     for(var i=0; i< $(this).val(); i++) {
       $('.passenger_details_container').append(personTemplate.clone());
     }
     $('.passenger_details_container').show();
  });

  $('.submit_enquiry_form').click(function() {
    var passengers = [];
    $('.passenger_details_container .control-group').each(function() {
      name = $(this).find('input').first().val();
      age = $(this).find('input').last().val();
      passengers.push({name: name, age: age});
    });
    $('#enquiry_passenger_details').attr('value', JSON.stringify(passengers));
    $('#new_enquiry').submit();
  });

  $('#enquiry_date').datepicker();
});
