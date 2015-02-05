angular.module('AngularRails', [
        'ngRoute',
        'templates'
  ])

.config(function ($routeProvider, $locationProvider) {
  $routeProvider
    .when('/', {
      templateUrl: 'home.html',
      controller: 'HomeCtrl'
    })
    .when('/sign_in', {
      templateUrl: 'views/user_sessions/new.html',
      controller: 'UserSessionsCtrl'
     });
});
