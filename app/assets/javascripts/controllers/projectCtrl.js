app.controller('projectCtrl', ['$scope', 'Restangular', 'storage',function($scope, Restangular, storage){
  
  $scope.data = storage.data;
  $scope.logged = storage.auth;

  

}]);