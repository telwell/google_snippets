app.controller('authCtrl', ['$scope', 'Restangular', 'Auth', function($scope, Restangular, Auth){
  $scope.registration = false;

  $scope.logged = Auth.isAuthenticated();

      // console.log(Auth.isAuthenticated()); // => false

      //   // Log in user...

      // console.log(Auth.isAuthenticated()); // => true

      // Auth.currentUser().then(function(user) {
      //       // User was logged in, or Devise returned
      //       // previously authenticated session.
      //       console.log(user); // => {id: 1, ect: '...'}
      //   }, function(error) {
      //       // unauthenticated error
      //   });

 

      $scope.Login = function(){
        console.log("Logging in");
        var credentials = {
          email: $scope.User.email,
          password: $scope.User.password
        };
        var config = {
          headers: {
              'X-HTTP-Method-Override': 'POST'
          }
        };
        Auth.login(credentials, config).then(function(user) {
          console.log(user); // => {id: 1, ect: '...'}

          $scope.logged = Auth.isAuthenticated();
        }, function(error) {
            // Authentication failed...
            console.log("failed" , error);
        });
      };

      $scope.Logout = function(){
          var config = {
            headers: {
                'X-HTTP-Method-Override': 'DELETE'
            }
          };
        Auth.logout(config).then(function(oldUser) {
            // alert(oldUser.name + "you're signed out now.");
          $scope.logged = Auth.isAuthenticated();
        }, function(error) {
            // An error occurred logging out.
        });
        
      };


        // $scope.$on('devise:logout', function(event, oldCurrentUser) {
        //     // ...
        // });

        // $scope.$on('devise:login', function(event, currentUser) {
        //     // after a login, a hard refresh, a new tab
        // });

        // $scope.$on('devise:new-session', function(event, currentUser) {
        //     // user logged in by Auth.login({...})
        // });

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