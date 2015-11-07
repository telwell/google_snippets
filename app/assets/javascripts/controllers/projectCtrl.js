app.controller('projectCtrl', ['$scope', 'Restangular', function($scope, Restangular){
  $scope.test = "Project";
  Restangular.get('projects').customGET('project_page').then(function(response){
  	response {}
  }, function(error){
  	// flash message error
  })
}]);