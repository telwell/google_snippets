app = angular.module('app', ['ui.router', 'restangular', 'ui.bootstrap', 'Devise'])
.config(['RestangularProvider', function(RestangularProvider){
  // RestangularProvider.setBaseUrl('api/v1');
  RestangularProvider.setRequestSuffix('.json');
  RestangularProvider.setDefaultHttpFields({
    "content-type":"application/json"
  });
}])
.config(function(AuthProvider) {
        // Configure Auth service with AuthProvider
    })
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
      .state('project',{
        url: '/project/:id',
        views: {
          '':{
            templateUrl: 'templates/project.html',
            controller: 'projectCtrl'
          },
          'navbar' : {
            templateUrl: 'templates/partials/navbar.html',
            controller: 'navbarCtrl'
          }
        }
      })
      .state('user',{
        url: '/user/:id',
        views: {
          '':{
            templateUrl: 'templates/user.html',
            controller: 'userCtrl'
          },
          'navbar' : {
            templateUrl: 'templates/partials/navbar.html',
            controller: 'navbarCtrl'
          }
        }
      })

      .state('snippet',{
        url: '/snippet/:id',
        views: {
          '':{
            templateUrl: 'templates/snippet.html',
            controller: 'snippetCtrl'
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