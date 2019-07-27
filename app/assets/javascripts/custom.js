// var expenses = gon.arr_month_expenses;
// var length = gon.length;
// expenses.forEach(function( value ) {
  
// });
// var pieData = [
//   {
//     value: expenses[0][0]['emoney'],
//     color:"#9acce3",
//     highlight: "#aadbf2",
//     label: expenses[0][0]['ecategory_id']
//   },
//   {
//     value: expenses[0][0]['emoney'],
//     color: "#70b062",
//     highlight: "#7fc170",
//     label: "eating_out"
//   },
//   {
//     value: 2000,
//     color: "#dbdf19",
//     highlight: "#ecef23",
//     label: "daily_necessities"
//   },
//   {
//     value: 1000,
//     color: "#a979ad",
//     highlight: "#bb8ebf",
//     label: "traffic"
//   },
//   {
//     value: 3,
//     color: "#cd5638",
//     highlight: "#e2694a",
//     label: "clothes"
//   },
//   {
//     value: 0,
//     color: "#cd5638",
//     highlight: "#e2694a",
//     label: "companionship"
//   },
//   {
//     value: 0,
//     color: "#cd5638",
//     highlight: "#e2694a",
//     label: "hobby"
//   },
//   {
//     value: 0,
//     color: "#cd5638",
//     highlight: "#e2694a",
//     label: "other"
//   }

// ];

// window.onload = function(){
//   var ctx = document.getElementById("pie-chart").getContext("2d");
//   window.myPie = new Chart(ctx).Pie(pieData);
// };


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