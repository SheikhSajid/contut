// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

// $(function () {
//   if ($('#message-list').length > 0) {
//     console.log("commencing get");
//     $.ajax({
//       url: '/messages',
//       data: { student_id: 1, after_id: 450 },
//       dataType: 'script',
//       success: function(){
//         console.log( "get executed" );
//       }
//     });
//   }
// });

window.Poller = {
  request: function() {
    console.log('sending request');
    var last_id = $('.message').last().data('id');
    var student_id = $('#message_student_id').attr('value');
    var tutor_id = $('#message_tutor_id').attr('value');
    $.get('/messages', { student_id: student_id, tutor_id: tutor_id, after_id: last_id }, undefined, 'script');
  },
  
  poll: function(timeout) {
    if(timeout == 0) {
      this.request();
    } else {
      console.log("else entered. timeout = " + timeout);
      this.pollTimeout = setTimeout(this.request, timeout);
    }
  },
  
  clear: function() { clearTimeout(this.pollTimeout); }
};

$(function() {
  if ($('#message-list').length > 0) {
    // console.log("commencing get");
    // $.get('/messages', { student_id: 1, after_id: 450 }, undefined, 'script');
    Poller.poll(5000);
  }
});

// jQuery(function() {
//   if ($('#comments').size() > 0) {
//     return Poller.poll();
//   }
// });