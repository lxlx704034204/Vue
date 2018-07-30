<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%
    String path = request.getContextPath()+"/";
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>Title</title>
    <script type=text/javascript src="js/jquery.js"></script>
    <link rel="stylesheet" href="js/layui/css/layui.css" media="all">
    <style>
        .layui-show{
            background-color:#f2f2f2;
            height: 100%;
        }
    </style>
</head>
<body>
    <div class="layui-tab layui-tab-brief" lay-filter="OneTab">
        <ul class="layui-tab-title">
            <li class="layui-this">客户利润汇总</li>
            <li>客户利润详情</li>
        </ul>

        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
                <%--页签一--%>
                <div class="layui-row">
                    <%--左半部分--%>
                    <div class="layui-col-xs6">
                        <div>
                            <%--表格--%>
                            <table class="layui-hide" id="test" lay-filter="demo"></table>
                        </div>
                    </div>
                    <%--右半部分--%>
                    <div class="layui-col-xs6">
                        <div class="layui-row">
                            <%--右上半部分--%>
                            <div class="layui-col-xs6">
                                <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
                                <div id="main" style="width: 600px;height:250px;"></div>
                            </div>
                            <%--右下半部分--%>
                             <div class="layui-row">
                                <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
                                <div id="main2" style="width: 600px;height:250px;"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%--页签二--%>
            <div class="layui-tab-item">
                内容2
            </div>
        </div>
    </div>



    <script type=text/javascript src="js/jquery.js"></script>
    <script type=text/javascript src="js/echarts.min.js"></script>
    <script src="js/layui/layui.js" charset="utf-8"></script>
    <script>
        layui.use('table', function () {
            var table = layui.table;
            //地图信息
            table.render({
                elem: '#test'
                , url: 'locationall'
                , method: "post"
                , cellMinWidth: 80 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
                , cols: [[
                    {field: 'placename', width: 200, title: '地名', sort: true}
                    , {field: 'address', width: 230, title: '地址', edit: true}
                    , {field: 'province', width: 100, title: '省份', sort: true}
                    , {field: 'provincecode', width: 100, title: '省份编码', sort: true}
                ]]
                , even: true  //阴影间隔
                , page: true
            });
        })


        //注意：选项卡 依赖 element 模块，否则无法进行功能性操作
        layui.use('element', function(){
            var element = layui.element;

            //…
        });


    </script>

    <%--扇形图--%>
    <script>
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
                    data:[]  //为空，下面赋值
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

    <%--柱状图--%>
    <script>
        var myChart2 = echarts.init(document.getElementById('main2'),'light');
        var option2 = {
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
                data:['销量','存货']
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
                data: ["衬衫","羊毛衫","雪纺衫","裤子","高跟鞋"]
            },
            yAxis: {
                show: true,
                type: 'value',
                splitArea: {show: false}
            },
            series: [{
                name: '销量',
                type: 'bar',
                data: [5, 20, 36, 10, 15],
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
                name: '存货',
                type: 'bar',
                data: [15, 25, 40, 15, 17]
            }]
        };
        myChart2.setOption(option2);

    </script>
</body>
</html>
