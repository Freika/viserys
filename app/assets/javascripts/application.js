//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require angular
//= require angular-route
//= require angular-rails-templates
//= require_tree ../templates
//= require_tree .
//= require bootstrap-datepicker
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.ru.js

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
