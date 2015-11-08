app = angular.module('app', ['ui.router', 'restangular', 'ui.bootstrap', 'Devise'])
.config(['RestangularProvider', function(RestangularProvider){
  // RestangularProvider.setBaseUrl('api/v1');
  RestangularProvider.setRequestSuffix('.json');
  RestangularProvider.setDefaultHttpFields({
    "content-type":"application/json"
  });
}])
// .config([
//   "$httpProvider", function($httpProvider) {
//     $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
//   }
// ])
.config(function(AuthProvider) {
        // Configure Auth service with AuthProvider
    })
.filter('rawHtml', ['$sce', function($sce){
  return function(val) {
    return $sce.trustAsHtml(val);
  };
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
        },
        resolve: {
          'check': function(storage){
            storage.checkAuth();
          }
        }
      })
      .state('company',{
        url: '/company/:company_id',
        views: {
          '':{
            templateUrl: 'templates/company.html'
            
          },
          'navbar' : {
            templateUrl: 'templates/partials/navbar.html',
            controller: 'navbarCtrl'
          }
        }
      })
      .state('company.dashboard',{
        url: '/dashboard',
        views: {
          '':{
            templateUrl: 'templates/dashboard.html',
            controller: 'dashboardCtrl'
          }
        },
        resolve: {
          'check': function( $stateParams, $location, storage){
            storage.checkAuth($stateParams.company_id);

          }
        }
      })
      .state('company.project',{
        url: '/project/:project_id',
        views: {
          '':{
            templateUrl: 'templates/project.html',
            controller: 'projectCtrl'
          }
        },
        resolve: {
          'check': function( $stateParams, $location, storage){
            storage.checkAuth($stateParams.company_id);
            storage.getProject($stateParams.project_id);

          }
        }
      })
      .state('company.user',{
        url: '/user/:user_id',
        views: {
          '':{
            templateUrl: 'templates/user.html',
            controller: 'userCtrl'
          }
        },
        resolve: {
          'check': function( $stateParams, $location, storage){
            storage.checkAuth($stateParams.company_id);
            console.log("Resolve user", $stateParams.user_id);
            storage.getUser($stateParams.user_id);
          }
        }
      })

      .state('company.snippet',{
        url: '/snippet/:snippet_id',
        views: {
          '':{
            templateUrl: 'templates/snippet.html',
            controller: 'snippetCtrl'
          }
        },
        resolve: {
          'check': function( $stateParams, $location, storage){
            storage.checkAuth($stateParams.company_id);

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