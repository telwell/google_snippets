app.controller('projectCtrl', ['$scope', 'Restangular', function($scope, Restangular){
  $scope.test = "Project";
  Restangular.get('projects').customGET('project_page').then(function(response){
  	// Stuff
  }, function(error){
  	// flash message error
  })
}]);