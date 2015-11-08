app.controller('userCtrl', ['$scope', 'storage', function($scope, storage){
  $scope.data = storage.data;
  $scope.logged = storage.auth;
  $scope.postSnippet = function(){
    storage.newSnippet($scope.Snippet);
    
  };
  
  $scope.username = storage.data.user.user.first_name;
  
}]);