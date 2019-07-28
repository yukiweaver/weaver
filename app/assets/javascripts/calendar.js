// FullCalendarの設定を読み込み、お及びFullCalendarを削除
$(function () {
  function eventCalendar() {
      return $('#calendar').fullCalendar({});
  };
  function clearCalendar() {
      $('#calendar').html('');
  };
  $(document).on('turbolinks:load', function () {
    eventCalendar();
  });
  $(document).on('turbolinks:before-cache', clearCalendar);
  $('#calendar').fullCalendar({
    events: '/expenses.json'
  });
});