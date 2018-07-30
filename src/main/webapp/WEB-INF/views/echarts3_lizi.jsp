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

    <script type=text/javascript src="js/jquery.js"></script>
    <!-- 引入 ECharts 文件 -->
    <script type=text/javascript src="js/echarts.min.js"></script>
    <script>
        var myChart = echarts.init(document.getElementById('main'),'light');
        myChart.setOption({
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
                data:['编号','年龄']
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
                    saveAsImage: {}
                }
            },
            //x轴信息样式
            xAxis: {
                type: 'category',
                boundaryGap: false,//坐标轴两端空白策略，数组内数值代表百分比.
                data: [],
                //x轴文字旋转
                axisLabel:{
                    //倾斜
                    // rotate:30,
                    // interval:0

                    //直立
                    // interval: 0,
                    // formatter:function(value)
                    // {
                    //     return value.split("").join("\n");
                    // }
                },
            },
            yAxis : [
                {
                    type : 'value',
                    axisLabel : {
                        // formatter: '{value} 人'
                    }
                }
            ],
            series: [
                {
                    name:'编号',
                    type:'line',
                    symbolSize:5,   //拐点圆的大小
                    color:['#5A95F5'],  //折线条的颜色
                    data:[],
                    itemStyle:{
                        normal:{
                            //color:'blue',//会覆盖上面的折线颜色color，且影响实心转折点的颜色（空心无影响）
                            // borderColor:'red',  //拐点边框颜色
                        }
                    }
                },
                {
                    name:'年龄',
                    type:'line',
                    symbolSize:3,
                    color:['yellow'],
                    itemStyle:{
                        normal:{
                            // borderColor:'red'  //拐点边框颜色
                        }
                    },
                    data:[]
                }
            ]
        }
        );

        //异步加载数据
        $.post('findalll',{},
            function(data) {  //data为json数组字符串
                var jsonObj = eval('('+data+')');//转换为json对象数组
                var json1 = [];
                var json2 = [];
                var str = [];
                for(var j = 0;j<jsonObj.length;j++){
                    var row = {"value":jsonObj[j].sid,"name":jsonObj[j].sname} //获取需要的字段
                    json1.push(row); //组成新的json数据

                    var row2 = {"value":jsonObj[j].sid+1,"name":jsonObj[j].sname} //获取需要的字段
                    json2.push(row2); //组成新的json数据

                    str.push(jsonObj[j].sname);
                }
                console.log(str);//姓名

                // 填入数据
                myChart.setOption({
                    // legend:{
                    //     data:json1.name
                    // },
                    xAxis: {
                        data:str
                    },
                    series: [{
                        name: '编号',
                        data: json1
                    },{
                        name: '年龄',
                        data: json2
                    }]
                });
            }
        )

    </script>
</body>
</html>
