app = angular.module('app', ['ui.router', 'restangular', 'ui.bootstrap'])
.config(['RestangularProvider', function(RestangularProvider){
  // RestangularProvider.setBaseUrl('api/v1');
  RestangularProvider.setRequestSuffix('.json');
  RestangularProvider.setDefaultHttpFields({
    "content-type":"application/json"
  });
}])
.config(['$stateProvider', '$urlRouterProvider', function($stateProvider, $urlRouterProvider){

    $stateProvider
      .state('index',{
        url: '/',
        views: {
          '':{
            templateUrl: 'templates/index.html',
            controller: 'mainCtrl'
          },
          'navbar' : {
            templateUrl: 'templates/partials/navbar.html',
            controller: 'navbarCtrl'
          }
        }

      })
      .state('dashboard',{
        url: '/dashboard',
        views: {
          '':{
            templateUrl: 'templates/dashboard.html',
            controller: 'dashboardCtrl'
          },
          'navbar' : {
            templateUrl: 'templates/partials/navbar.html',
            controller: 'navbarCtrl'
          }
        }
      })
      .state('auth',{
        url: '/auth',
        views: {
          '':{
            templateUrl: 'templates/auth.html',
            controller: 'authCtrl'
          },
          'navbar' : {
            templateUrl: 'templates/partials/navbar.html',
            controller: 'navbarCtrl'
          }
        }
      });

      $urlRouterProvider.otherwise('/');
}]);