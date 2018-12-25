$ ->
  maxlength = 100;
  $('#user_content').keyup ->
    length = $(this).val().length;
    minlength = maxlength - length;
    limit = "你还可以输入"+minlength+"个字";
    $('.limit').text(limit);

