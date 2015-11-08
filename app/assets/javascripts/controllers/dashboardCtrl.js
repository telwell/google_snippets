app.controller('dashboardCtrl', ['$scope', 'storage', function($scope, storage){
  $scope.data = storage.data;
  console.log("Dashboard data is ", $scope.data)
  $scope.logged = storage.auth;
  

  $scope.newProject = function(){
    storage.newProject($scope.Project);
    $scope.projectForm = undefined;
  };
}]);