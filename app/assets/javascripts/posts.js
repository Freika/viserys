$( document ).ready(function() {
  $('#post_created_at').datepicker({
    todayBtn: "linked",
    clearBtn: true,
    language: "ru",
    autoclose: true,
    todayHighlight: true
  });

  $('.graph-wrapper').load('/graph #graph', function(){
    $('#graph a').tooltip();
  });

  $('img').addClass('img-responsive');
});
