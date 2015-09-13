
  $(document).ready(function() {
    if($('#user_gender').val() == 'Female'){
      $('#user_salutation').empty().append("<option>Miss</option>");
      $('#user_salutation').append("<option>Ms</option>");
      $('#user_salutation').append("<option>Mrs</option>");
      $('#user_salutation').append("<option>Madame</option>");
      $('#user_salutation').append("<option>Majesty</option>");
      $('#user_salutation').append("<option>Seniora</option>");
    }
    $('#user_gender').change(function() {
      if($('#user_gender').val() == 'Male'){
        $('#user_salutation').empty().append("<option>Mr</option>");
        $('#user_salutation').append("<option>Sir</option>");
        $('#user_salutation').append("<option>Senior</option>");
        $('#user_salutation').append("<option>Count</option>");
      }
      else if($('#user_gender').val() == 'Female'){
        $('#user_salutation').empty().append("<option>Miss</option>");
        $('#user_salutation').append("<option>Ms</option>");
        $('#user_salutation').append("<option>Mrs</option>");
        $('#user_salutation').append("<option>Madame</option>");
        $('#user_salutation').append("<option>Majesty</option>");
        $('#user_salutation').append("<option>Seniora</option>");
      }
    });
  });
