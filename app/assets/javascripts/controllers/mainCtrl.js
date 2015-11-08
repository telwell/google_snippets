app.controller('mainCtrl', ['$scope', 'storage', function($scope, storage){
  $scope.logged = storage.auth;
}]);
