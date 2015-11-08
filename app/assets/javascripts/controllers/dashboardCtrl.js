app.controller('dashboardCtrl', ['$scope', 'storage', function($scope, storage){
  $scope.data = storage.data;
  $scope.logged = storage.auth;
  storage.getDashboard($scope.logged.user.id);
}]);