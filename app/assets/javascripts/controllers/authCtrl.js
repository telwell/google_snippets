app.controller('authCtrl', ['$scope', 'Restangular', function($scope, Restangular){
  $scope.registration = false;
  $scope.SignIn = function(){
    // Send credentials to server
    Restangular.all('users').customPOST({data: $scope.User}, 'sign_in').then(function(response){
      // Response status 200
      if (response == 'confirm'){
        $location.path('/dashboard');}
      else
        {$scope.alert = response.message;}
      
      
    }, function(response){
      //Bad response
      $scope.alert = "Something went wrong try again later.";
    });
  };
}]);