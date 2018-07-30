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
    <div id="main" style="width: 600px;height:400px;"></div>

    <script type=text/javascript src="js/jquery.js"></script>
    <!-- 引入 ECharts 文件 -->
    <script type=text/javascript src="js/echarts.min.js"></script>
    <script>
        //json对象数组
        var json = [
            {value:'90',name:'高'},
            {value:'27',name:'赵'},
            {value:45,name:'江'},
            {value:21,name:'圆'},
            {value:30,name:'丽'},
            {value:18,name:'莱'}
        ]
        console.log(json)

        var myChart = echarts.init(document.getElementById('main'),'light');
        myChart.setOption({
            title : {
                text: '女神年龄分布',
                subtext: '独家报道',
                x:'center'
            },
            //提示框
            tooltip : {
                trigger: 'item',
                //提示框文字格式
                formatter: "{a} <br/>{b} : {c} 岁"
            },
            //图例
            legend: {
                orient : 'vertical',//垂直的
                x : 'left',
                data:[]
            },
            //工具箱
            toolbox:{
                //显示策略，可选为：true（显示） | false（隐藏），默认值为false
                show: true,
                //启用功能，目前支持feature，工具箱自定义功能回调处理
                feature: {
                    //辅助线标志
                    mark: {show: true},
                    //数据视图，打开数据视图，可设置更多属性,readOnly 默认数据视图为只读(即值为true)，可指定readOnly为false打开编辑功能
                    dataView: {show: true, readOnly: false},
                    //restore，还原，复位原始图表
                    restore: {show: true},
                    //saveAsImage，保存成图片（IE8-不支持）,图片类型默认为'png'
                    saveAsImage: {show: true}
                }
            },
            series : [
                {
                    name: '女神',
                    type: 'pie',
                    radius: '55%', //饼图的半径大小
                    center: ['50%', '60%'],//饼图的位置
                    data:[], //为空，下面赋值
                    itemStyle : { //是否显示延伸线和文字
                        normal: {
                            label: {
                                show: true
                            },
                            labelLine: {
                                show: true
                            }
                        }
                    }
                }
            ]
        });

        //异步加载数据
        $.post('findalll',{},
            function(data) {  //data为json数组字符串
                var jsonObj = eval('('+data+')');//转换为json对象数组
                var json1 = [];
                for(var j = 0;j<jsonObj.length;j++){
                    var row = {"value":jsonObj[j].sid,"name":jsonObj[j].sname} //获取需要的字段
                    json1.push(row); //组成新的json数据
                }

                // 填入数据
                myChart.setOption({
                    legend:{
                        data:json1.name
                    },
                    series: [{
                        name: '女神',
                        data: json1
                    }]
                });
            }
        )
    </script>
</body>
</html>
