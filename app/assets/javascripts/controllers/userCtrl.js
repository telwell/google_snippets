app.controller('userCtrl', ['$scope', 'storage',function($scope, storage){
  $scope.data = storage.data;
  $scope.logged = storage.auth;
  storage.getUser($scope.logged.user.id);
}]);