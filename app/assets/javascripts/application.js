// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery

//= require vue
//= require twitter/bootstrap
//= bootstrap-sprockets
//= require jquery.validate
//= require icheck.min
//= require jquery.floatThead.min
//= require rails-ujs
//= require turbolinks
//= require_tree .
//= require bootstrap-datepicker
//= require select2-full
//= require jquery.raty
//= require ratyrate
//= require jquery.cookie

$(document).ready(function(){
  $('.dog').click(function(){
    var url = $(this).parent().attr('data-id')
    $.ajax({
      url: '/users/' + url,
      type: 'DELETE',
      dataType: 'json',
      success: function(data){
       $('#user_delete_' + data.id).remove();
      },
      error: function(data){
      },
    });
  });
});

$(document).ready(function(e){
  $('.form-create').on("submit", function(){
    $.ajax({
      url: $(this).attr('action'),
      type: 'POST',
      data: $(this).serialize(),
      dataType: 'script',
      success: function(data){
        console.log(data)
      },
    });
    e.preventDefault();
  });
});

// $(document).ready(function(){
//   $('.list').on('submit', function(){
//     var start_at = $('#start_at').val()
//     var end_at = $('#end_at').val()
//     $.ajax({
//       url: $(this).attr('action'),
//       type: 'GET',
//       data: {start_at: start_at, end_at: end_at},
//       dataType: 'json',
//       success: function(data){
//         console.log(data.name)
//       },
//     });
//   });
// });

$(document).ready(function() {
  $('#user_tag_ids').select2();
});

$(document).ready(function(){
  $('#rating i').hover( function(){
    $(this).add($(this).prevAll("i")).removeClass("fa-star-o").addClass("fa-star");
    $(this).nextAll("i").removeClass('fa fa-star').addClass('fa fa-star-o');
    var id = $('.star').attr('data-p');
    $('#rating_score').val(id);
    var rating = $('.star').data('data-rating');
    if(rating){
      $.ajax({
        url: "/products/"+id+"/ratings/",
        type: 'DELETE',
        dataType: 'json',
        data: {product_id: id},
        success: function(data){
        }
      })
    }else{
      $.ajax({
        url: "/products/"+id+"/ratings/",
        type: 'POST',
        dataType: 'json',
        data: {product_id: id},
        success: function(data){
          $('.star').data('data-rating', data.rating.id);
        }
      })
    }
  })
})
