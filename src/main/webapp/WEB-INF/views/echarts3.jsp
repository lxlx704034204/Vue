<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath() + "/";
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<html>
<head>
    <title>Title</title>
    <base href="<%=basePath%>">
</head>
<body>
    <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
    <div id="main" style="width: 800px;height:500px;"></div>

    <!-- 引入 ECharts 文件 -->
    <script type=text/javascript src="js/echarts.min.js"></script>
    <script>
        var myChart = echarts.init(document.getElementById('main'),'light');
        var option = {

            title: { // 标题
                text: '红包活动数据',
                subtext: '数据来源'
            },
            //提示框
            tooltip: {
                trigger: 'axis'
            },
            //图例名
            legend: {
                data:['参加活动人数','分享人数','注册人数']
            },
            grid: {
                left: '3%',   //图表距边框的距离
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            //工具框，可以选择
            toolbox: {
                feature: {
                    dataView: {show: true, readOnly: false},
                    saveAsImage: {}
                }
            },
            //x轴信息样式
            xAxis: {
                type: 'category',
                boundaryGap: false,//坐标轴两端空白策略，数组内数值代表百分比.
                data: ['1','2','3','4','5','6','7','8','9','10','11','12'],
                //坐标轴颜色
                axisLine:{
                    lineStyle:{
                        // color:'blue'
                    }
                },
                //x轴文字旋转
                axisLabel:{
                    rotate:30,
                    interval:0
                },
            },
            yAxis : [
                {
                    type : 'value',
                    axisLabel : {
                        formatter: '{value} 人'
                    }
                }
            ],
            series: [
                //虚线
                {
                    name:'参加活动人数',
                    type:'line',
                    symbolSize:4,   //拐点圆的大小
                    color:['red'],  //折线条的颜色
                    //symbol:'circle', //图形，默认空心圆 'circle'实心圆, 'rect'实心方, 'roundRect'实心圆方, 'triangle'实心三角, 'diamond'实心菱形, 'pin'定位点, 'arrow'实心三角箭头
                    data:[900, 300, 500, 800, 300, 600, 500, 800, 300, 500, 800, 300],
                    smooth:false,   //关键点，为true是不支持虚线的，实线就用true
                    itemStyle:{
                        normal:{
                            //color:'blue',//会覆盖上面的折线颜色color，且影响实心转折点的颜色（空心无影响）
                            borderColor:'yellow',  //拐点边框颜色
                            lineStyle:{
                                width:2,
                                type:'dotted'  //'dotted'虚线 'solid'实线
                            }
                        }
                    }
                },
                //实线
                {
                    name:'分享人数',
                    type:'line',
                    symbolSize:4,
                    color:['yellow'],
                    itemStyle:{
                        normal:{
                            borderColor:'red'  //拐点边框颜色
                        }
                    },
                    data:[220, 182, 191, 234, 290, 330, 310, 220, 182, 191, 234, 290]
                },
                //虚线
                {
                    name:'注册人数',
                    type:'line',
                    symbolSize:4,
                    symbol:'circle',
                    color:['blue'],
                    itemStyle:{
                        normal:{
                            borderColor:'green',
                            lineStyle:{
                                width:2,
                                type:'dotted'  //'dotted'虚线 'solid'实线
                            }
                        }
                    },
                    data:[300, 232, 201, 154, 190, 330, 410,150, 232, 201, 154, 190]
                }
            ]
        }
        myChart.setOption(option);

    </script>
</body>
</html>
