app.controller('dashboardCtrl', ['$scope', '$sce','storage', function($scope, $sce,storage){
  $scope.data = storage.data;
  $scope.logged = storage.auth;
  storage.getDashboard($scope.logged.user.id);
}]);