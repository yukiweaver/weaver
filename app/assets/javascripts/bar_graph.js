var barChartData = {
  labels : ["2月","3月","4月","5月","6月","7月","8月"],
  datasets : [
    {
      fillColor : /*"#d685b0"*/"rgba(214,133,176,0.7)",
      strokeColor : /*"#d685b0"*/"rgba(214,133,176,0.7)",
      highlightFill: /*"#eebdcb"*/"rgba(238,189,203,0.7)",
      highlightStroke: /*"#eebdcb"*/"rgba(238,189,203,0.7)",
      data : [0,0,0,0,50000,75000,100000]
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