$( document ).ready(function() {
  $('td a').tooltip();

  $('#post_created_at').datepicker({
    todayBtn: "linked",
    clearBtn: true,
    language: "ru",
    autoclose: true,
    todayHighlight: true
  });
});
