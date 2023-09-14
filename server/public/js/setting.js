$(document).ready(function () {
  $('#mode').on('change', function (e) {
    $.get('/api/userSetting/darkMode')
  })
})
