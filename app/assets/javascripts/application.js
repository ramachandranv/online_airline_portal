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

var adultTemplate = $("<div class='control-group'><div class='controls adult'>&nbsp;&nbsp;<input type='hidden' name='person' value='Adult'><select name='title' class='title'><option>Title</option><option>Mr</option><option>Ms</option><option>Mrs</option></select><input type='text' name='first_name' placeholder='First Name'><input type='text' name='last_name' placeholder='Last Name'></div></div>");
var childTemplate = $("<div class='control-group'><div class='controls child'>&nbsp;&nbsp;<input type='hidden' name='person' value='Child'> <select name='title' class='title'><option>Title</option><option>Miss</option><option>Mstr</option></select><input type='text' name='first_name' placeholder='First Name'><input type='text' name='last_name' placeholder='Last Name'></div></div>");
var infantTemplate = $("<div class='control-group'><div class='controls infant'><input type='hidden' name='person' value='Infant'><select name='title' class='title'><option>Title</option><option>Miss</option><option>Mstr</option></select><input type='text' name='first_name' placeholder='First Name'><input type='text' name='last_name' placeholder='Last Name'></div></div>");
var passengers = []; 
var error_message = "";

$(document).ready(function() {
  $('#enquiry_airline_company').autocomplete({source: ['Indian Airlines', 'Air India', 'Kingfisher', 'Aerosource India Pvt Ltd']});
  $('#enquiry_source').autocomplete({source: ['Chennai', 'Bangalore', 'Bombay', 'Delhi']});
  $('#enquiry_destination').autocomplete({source: ['Chennai', 'Bangalore', 'Bombay', 'Delhi']});

  $("#enquiry_adults").change(function() {
    var adults_count = $('#enquiry_adults').val();
    var adult_template_count = $("#adults .adult").length;

    if (adult_template_count >= 0) {
      if (adult_template_count > adults_count) {
        adults_count = adult_template_count - adults_count;
        for (i=1; i <= adults_count; i++) {
          $('#adults .adult:last').remove();
        }
      } else {
        adults_count = adults_count - adult_template_count;
        for (i=1; i <= adults_count; i++) {
          $('#adults').append(adultTemplate.clone().find('.controls').prepend('Adult '+parseInt(adult_template_count+i)));
        }
      }
    }
  });

  $("#enquiry_children").change(function() {
    var children_count = $('#enquiry_children').val();
    var child_template_count = $(".passenger_details .child").length;
    if (child_template_count >= 0) {
      if (child_template_count > children_count) {
        children_count = child_template_count - children_count;
        for (i=1; i <= children_count; i++) {
          $('#children .child:last').remove();
        }
      } else {
        children_count = children_count - child_template_count;
        for (i=1; i <= children_count; i++) {
          $('#children').append(childTemplate.clone().find('.controls').prepend('Child '+parseInt(child_template_count+i)));
        }
      }
    }
  });

  $("#enquiry_infants").change(function() {
    var infants_count = $('#enquiry_infants').val();
    var infant_template_count = $(".passenger_details .infant").length;

    if (infant_template_count >= 0) {
      if (infant_template_count > infants_count) {
        infants_count = infant_template_count - infants_count;
        for (i=1; i <= infants_count; i++) {
          $('#infants .infant:last').remove();
        }
      } else {
        infants_count = infants_count - infant_template_count;
        for (i=1; i <= infants_count; i++) {
          $('#infants').append(infantTemplate.clone().find('.controls').prepend('Infant '+parseInt(infant_template_count+i)));
        }
      }
    } 
  });

  $('#accordion').accordion({disabled: true});

  $('.continue_enquiry_form').click(function() {
    if ($("#enquiry_source").val() == "" || $("#enquiry_destination").val() == "" || $("#enquiry_departure_date").val() == "" || ($("#enquiry_trip_type_round_trip").is(':checked') && $("#enquiry_return_date").val() == "")) {
      $(".enquiry_form .alert-error").html("Please fill in the mandatory fields Source, Destination, Departure Date and Return Date(if round trip)").addClass("error");
    } else {
      var adult_template_count = $("#adults .adult").length;
      $(".enquiry_form .alert-error").html("").removeClass("error");
      //$(this).attr('disabled', true);

      $(".passenger_details h3").html($("#enquiry_source").val()+" -------> "+$("#enquiry_destination").val());

      if (adult_template_count == 0) {
        $('#adults').append(adultTemplate.clone().find('.controls').prepend('Adult 1'));
      }

      if ($(".submit_enquiry_form").length == 0) {
        $('#submit_button').append("<input type='button' class='submit_enquiry_form btn btn-success' value='Submit Enquiry'>")
      }

      $('#accordion').accordion({disabled: false, active: 1});
    }
  });

  $('#enquiry_departure_date').datepicker();
  $('#enquiry_return_date').datepicker();

  $('#enquiry_trip_type_round_trip').click(function() {
    if($(this).is(':checked')) {
      $('.return_date').show();
      $('.departure_date').css({'float': 'left', width: '400px'});
    }
  });

  $('#enquiry_trip_type_one_way').click(function() {
    if($(this).is(':checked')) {
      $('.return_date').hide();
      $('.departure_date').css({'float': 'none'});
    }
  }); 

  $('.passenger_details').delegate('.submit_enquiry_form', 'click', function() {
    $('.passenger_details .controls').each(function() {
        var person_type = $(this).find('input:first').val();
        var title = $(this).find('select').val();
        var first_name = $(this).find('select').next().val();
        var last_name = $(this).find('input:last').val();
        if (title == "title" || first_name == "" || last_name == "") {
          error_message = "Please fill in all the fields properly";
        } else {
          $('.departure_time .controls').append("<input type='hidden' name='passenger_details[]' value='"+JSON.stringify({person_type: person_type, title: title, first_name: first_name, last_name: last_name})+"'>");
        }
    });
    if (error_message == "") {
      $('#new_enquiry').submit();
    } else {
      $(".passenger_details .alert-error").html(error_message).addClass("error");
      $(".departure_time .controls").find('input').remove();
      error_message = "";
    }
  });
});
