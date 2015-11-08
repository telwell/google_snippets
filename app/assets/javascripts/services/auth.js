app.service('storage', ['$http', '$location','$stateParams','Restangular', 'Auth', function($http, $location, $stateParams,Restangular, Auth){
  var obj = {};
  obj.data = {};
  //Data

  obj.getDashboard = function(id){
    
    Restangular.one('dashboard', id).get().then(function(response){
      console.log("Data", response);
      obj.data.dashboard = response;


    },
      function(error){
        console.log("No dashboard data returned");
      });
  };

  obj.newSnippet = function(snippet){

    Auth.currentUser().then(function(user) {
      console.log("newSnippet", snippet,user);
      snippet.user_id = user.id;
      Restangular.all('snippets').post(snippet).then(function(response){
        console.log("Snippet created", response);
        
      }, function(error){
        console.log("New snippet creation", error);
      });
    }, function(error) {
        // unauthenticated error
    });

  };

  obj.newProject = function(project){
    Restangular.all('projects').post(project).then(function(response){
      console.log("Project created", response);

    }, function(error){
      console.log("New user creation", error);
    });
  };

  obj.getUser = function(id){
    
    Restangular.one('users', id).get().then(function(response){
      console.log("Server send this user to data", response.user.id);
      obj.data.user = response;


    },
      function(error){
        console.log("No user data returned");
      });
  };

  obj.getProject = function(id){
    Restangular.one('projects', id).get().then(function(response){
      
      obj.data.project = response;


    },
      function(error){
        console.log("No project data returned");
      });
  };

  //Authorization
  obj.auth = {authorized: Auth.isAuthenticated()};

  obj.checkAuth = function(company_id){
    Auth.currentUser().then(function(user) {
        // User was logged in, or Devise returned
        // previously authenticated session.
        console.log("Auth.user is ", user);
        obj.auth.user = user;
        obj.auth.authorized = Auth.isAuthenticated();
        if (company_id && company_id != user.company_id){
          console.log(company_id, user.company_id, company_id && company_id != user.company_id);
          $location.path('/');
        }
        return user;
    }, function(error) {
        obj.auth.user = false;
        // unauthenticated error
        console.log("No currentUser");
        $location.path('/');
    });
  };

  obj.signup = function(user){
       console.log("in register function", user);
        var ncredentials = {
            email: user.email,
            password: user.password,
            password_confirmation: user.password,
            first_name: user.firstname,
            last_name: user.lastname,
            phone: user.phone,
            location: user.location,
            company: user.company
        };

        Auth.register(ncredentials).then(function(registeredUser) {
            console.log("registered ", registeredUser); // => {id: 1, ect: '...'};
            $location.path('/company'+registeredUser.company_id+'/dashboard');
        }, function(error) {
            console.log('Registration failed...');
        });

    // Restangular.all('users').post(user).then(function(response){
    //   var user = response;
    //   obj.login(user.email, user.password);

    // }, function(error){
    //   console.log("New user creation", error);
    // });
  };

  obj.login = function(email, password){
    console.log("Logging in");
    var credentials = {
      email: email,
      password: password
    };
    var config = {
      headers: {
          'X-HTTP-Method-Override': 'POST'
          
      }
    };
    Auth.login(credentials, config).then(function(user) {
      console.log("Logged in user", user); // => {id: 1, ect: '...'}
      obj.auth.user = user;
      obj.auth.authorized = Auth.isAuthenticated();
      $location.path('/dashboard');

    }, function(error) {
        // Authentication failed...
        console.log("failed" , error.data.error);
    });
  };
 

  obj.logout = function(){
    var config = {
            headers: {
                'X-HTTP-Method-Override': 'DELETE'
            }
    };
    Auth.logout(config).then(function(oldUser) {
      // alert(oldUser.name + "you're signed out now.");
      obj.auth.authorized  = Auth.isAuthenticated();
      obj.auth.user = false;
    }, function(error) {
        // An error occurred logging out.
        console.log("Failed to logout");
    });
  };



  return obj;

}]);