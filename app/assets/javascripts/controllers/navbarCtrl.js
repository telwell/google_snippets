app.controller('navbarCtrl', ['$scope', '$location', 'storage',  function($scope, $location,  storage){
  
  $scope.logged = storage.auth;
  
  console.log("In navbar ctrl user ", $scope.logged.user);
  

  $scope.Logout = storage.logout;

  $scope.$on('devise:logout', function(event, oldCurrentUser) {
      // 
      console.log("Logged out devise");
      $location.path('/');
  });
}]);