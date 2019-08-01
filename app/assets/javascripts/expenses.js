const CATEGORY_JA_CONVERT = {
  food: '食費',
  eating_out: '外食費',
  daily_necessities: '日用品',
  traffic: '交通費',
  clothes: '衣服',
  companionship: '交際費',
  hobby: '趣味',
  other: 'その他'
};
var expenses = gon.arr_month_expenses;
var pieData = [];
expenses.forEach(function( expense ) {
  array = {};
  array['value'] = expense[0]['emoney'];
  array['color'] = expense[0]['color'];
  array['highlight'] = expense[0]['highlight'];
  array['label'] = CATEGORY_JA_CONVERT[expense[0]['ecategory_id']];
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