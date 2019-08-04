var total_saving = gon.total_saving;
var labels = [];
var data = [];
total_saving.forEach(function( value ) {
  labels.push(value[0]);
  data.push(value[1]);
});
var barChartData = {
  labels : labels,
  datasets : [
    {
      fillColor : /*"#d685b0"*/"rgba(214,133,176,0.7)",
      strokeColor : /*"#d685b0"*/"rgba(214,133,176,0.7)",
      highlightFill: /*"#eebdcb"*/"rgba(238,189,203,0.7)",
      highlightStroke: /*"#eebdcb"*/"rgba(238,189,203,0.7)",
      data : data
    },
  ]

}
window.onload = function(){
  var ctx = document.getElementById("chart").getContext("2d");
  window.myBar = new Chart(ctx).Bar(barChartData, {
    responsive : true,
    // アニメーションを停止させる場合は下記を追加
    /* animation : false */
  });
}