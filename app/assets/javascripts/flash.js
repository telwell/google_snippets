// Flash Messages

//Example:
// $(document).ready(function() {

//   $('#foo').flash({
//     message: 'This is an informative and dismissable flash message!', //defaults to ''
//     type: 'warning', //defaults to 'info'
//     method: 'append', //defaults to 'prepend'
//     dismissable: true //defaults to 'true'
//   });

// });

(function($) {

  $.fn.flash = function(options) {

    //Ensure we have options
    options = options || {};

    //Allow Rails conventional keys to map
    //to Bootstrap classes
    switch (options.type) {
      case 'notice':
        options.type = 'info';
        break;
      case 'error':
        options.type = 'danger';
        break;
    }

    //Merge default options with settings
    var settings = $.extend({
      message: '',
      type: 'info',
      dismissable: true,
      method: 'prepend'
    }, options);

    //Output dismissable class and button only if desired
    var dismissable = settings.dismissable ? ' alert-dismissible' : '';
    var alertDismissableClass = dismissableButton = '';
    if (settings.dismissable) {
      alertDismissableClass = ' alert-dismissible';
      dismissableButton = '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' + 
          '<span aria-hidden="true">&times;</span>' +
      '</button>';
    }

    //Create Bootstrap markup
    var flashMessage = '<div class="alert alert-' +
        settings.type +
        dismissable +
        '" role="alert">' +
        settings.message +
        dismissableButton +
      '</div>';

    //User desired jQuery method to add to element
    if (settings.method == 'prepend') {
      return this.prepend(flashMessage);
    } else if (settings.method == 'append') {
      return this.append(flashMessage);

      //Throws informative error if method not supported
    } else {
      throw new Error(settings.method + ' is not a valid flash message method');
    }
    return null;
  };

  //Clears all dismissable alerts
  $.flash = {
    clear: function(){
      $('.alert.alert-dismissible').remove();
    }
  };

})(jQuery);





