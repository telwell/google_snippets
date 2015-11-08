app.controller('authCtrl', ['$scope', '$location','Restangular', 'Auth', 'storage', function($scope, $location, Restangular, Auth, storage){
  

  $scope.logged = storage.auth;

  $scope.Logout = storage.logout;
  $scope.Login = function(){
    storage.login($scope.User.email,$scope.User.password);
  };
  $scope.Signup = function(){
    storage.signup($scope.User);
  };

  $scope.$on('devise:logout', function(event, oldCurrentUser) {
      // 
      console.log("Logged out devise");
      $location.path('/');
  });

  $scope.$on('devise:login', function(event, currentUser) {
      // after a login, a hard refresh, a new tab
      $location.path('/dashboard');
  });

  // $scope.$on('devise:new-session', function(event, currentUser) {
  //     // user logged in by Auth.login({...})
  //     $location.path('/');
  // });

}]);