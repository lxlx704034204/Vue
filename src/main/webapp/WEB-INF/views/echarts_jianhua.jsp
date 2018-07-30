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
    <div id="main2" style="width: 600px;height:400px;"></div>

    <script type=text/javascript src="js/jquery.js"></script>
    <script type=text/javascript src="js/echarts.min.js"></script>
    <script>
        var myChart = echarts.init(document.getElementById('main2'),'light');
        myChart.setOption({
            title: {
                text: 'ECharts 入门示例',
                link: 'http://www.baidu.com',
                subtext: 'www.baidu.com',
                sublink: 'http://www.baidu.com',
                x: 'left',
                y: 'top'
            },
            tooltip: {
                trigger: 'item'
            },
            legend: {
                show: true,
                x: 'center',
                y: 'top',
                data:['编号','年龄']
            },
            toolbox:{
                show: true,
                feature: {
                    mark: {show: true},
                    dataZoom: {
                        show: true,
                        title: {
                            dataZoom: '区域缩放',
                            dataZoomReset: '区域缩放后退'
                        }
                    },
                    dataView: {show: true, readOnly: false},
                    magicType: {show: true, type: ['line', 'bar']},
                    restore: {show: true},
                    saveAsImage: {show: true}
                }
            },
            calculable: false,
            xAxis: {
                show: true,
                type: 'category',
                data: []
            },
            yAxis: {
                show: true,
                type: 'value',
                splitArea: {show: false}
            },
            series: [{
                name: '编号',
                type: 'bar',
                data: [],
                markPoint: {
                    data: [
                        {type: 'max', name: '最大值'},
                        {type: 'min', name: '最小值'}
                    ]
                },
                markLine: {
                    data: [
                        {type: 'average', name: '平均值'}
                    ]
                }
            },{
                name: '年龄',
                type: 'bar',
                data: []
            }]
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

