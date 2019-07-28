var expenses = gon.arr_month_expenses;
var pieData = [];
expenses.forEach(function( expense ) {
  array = {};
  array['value'] = expense[0]['emoney'];
  array['color'] = expense[0]['color'];
  array['highlight'] = expense[0]['highlight'];
  array['label'] = expense[0]['ecategory_id'];
  pieData.push(array);
});
// console.log(pieData);
// var pieData = [
//   {
//     value: 3000,
//     color:"#9acce3",
//     highlight: "#aadbf2",
//     label: 'food'
//   },
//   {
//     value: 2000,
//     color: "#70b062",
//     highlight: "#7fc170",
//     label: "eating_out"
//   },
// ];

window.onload = function(){
  var ctx = document.getElementById("pie-chart").getContext("2d");
  window.myPie = new Chart(ctx).Pie(pieData);
};


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