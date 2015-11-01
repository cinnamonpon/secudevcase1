
  $(document).ready(function() {

    $('body')
  .off('click.dropdown touchstart.dropdown.data-api', '.dropdown')
  .on('click.dropdown touchstart.dropdown.data-api', '.dropdown form', function (e) { e.stopPropagation() });

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

    var max_fields      = 10; //maximum input boxes allowed
    var wrapper         = $("#fields_wrap"); //Fields wrapper
    var add_button      = $("#add_field_btn"); //Add button ID

    var x = 1;

    $(document.body).on('change', '#type', function() {
      if($(this).val() == 'Date' || $(this).val() == 'date'){
        $(this).parent('div').replaceWith('<div><select name="condition[]"><option value="and">AND</option><option value="or">OR</option></select><select name="type[]" id="type"><option value="user">User</option><option value="date" selected>Date</option></select><select name="range[]" id="range"><option value=">=">>=</option><option value="<="><=</option><option value="=">=</option></select><input type="date" name="date[]" placeholder="yyyy-mm-dd"/><a href="#" class="remove_field">Remove</a></div>');
      }
      else if($(this).val() == 'User' || $(this).val() == 'user'){
        $(this).parent('div').replaceWith('<div><select name="condition[]"><option value="and">AND</option><option value="or">OR</option></select><select name="type[]" id="type"><option value="user">User</option><option value="date">Date</option></select><input type="text" name="username[]"/><a href="#" class="remove_field">Remove</a></div>');
      }
    });

    $(add_button).click(function(e){ //on add input button click
        e.preventDefault();
        if(x < max_fields){ //max input box allowed
            x++; //text box increment
            $(wrapper).append('<div><select name="condition[]"><option value="and">AND</option><option value="or">OR</option></select><select name="type[]" id="type"><option value="user">User</option><option value="date">Date</option></select><input type="text" name="username[]"/><a href="#" class="remove_field">Remove</a></div>'); //add input box
        }
    });

    $(wrapper).on("click",".remove_field", function(e){ //user click on remove text
        e.preventDefault(); $(this).parent('div').remove(); x--;
    });

    $(":file").filestyle({
      input: false
    })
});
