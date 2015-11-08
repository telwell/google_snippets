app.controller('userCtrl', ['$scope', 'storage', function($scope, storage){
  $scope.data = storage.data;
  $scope.logged = storage.auth;
  console.log("Data in userCtrl", $scope.data.user.user.id);
  $scope.username = $scope.data.user.user.first_name+" "+$scope.data.user.user.last_name;
  
}]);