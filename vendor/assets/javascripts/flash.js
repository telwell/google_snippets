// Flash Messages

// //Example:
// $(document).ready(function() {

//   $('#foo').flash({
//     message: 'This is an informative and dismissable flash message!', //defaults to ''
//     type: 'warning', //defaults to 'info'
//     method: 'append', //defaults to 'prepend'
//     dismissable: true, //defaults to 'true'
//     id: 'my-awesome-id', //defaults to 'flash-message-info'
//     className: 'css-classes-here like-normal' //defaults to ''
//   });

//   $.flash.clear(); //removes all dismissable flash messages
//   //$.flash.remove(); //alias for $.flash.clear();
//   //$('#my-awesome-id').remove(); //Use regular jQuery remove to target specific elements

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
      method: 'prepend',
      id: 'flash-message-info',
      className: ''
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

    //Check if we should append any classes
    //to the container div
    settings.className = (settings.className != '') ? ' ' + settings.className : '';

    //Create Bootstrap markup
    var flashMessage = '<div id="' + settings.id + '" class="alert alert-' +
        settings.type +
        dismissable +
        settings.className +
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
    clear: function() {
      $('.alert.alert-dismissible').remove();
    },
    remove: function() {
      $('.alert.alert-dismissible').remove();
    }
  };

})(jQuery);



