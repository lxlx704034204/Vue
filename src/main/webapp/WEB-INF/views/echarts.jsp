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

    <!-- 引入 ECharts 文件 -->
    <script type=text/javascript src="js/echarts.min.js"></script>
    <script>
        // 基于准备好的dom，初始化echarts实例，主题有三套（默认，light，dark）
        var myChart = echarts.init(document.getElementById('main'),'light');
        // 指定图表的配置项和数据
        var option = {
            //标题，每个图表最多仅有一个标题控件，每个标题控件可设主副标题
            title: {
                //主标题文本，'\n'指定换行
                text: 'ECharts 入门示例',
                //主标题文本超链接，也可内链（不加http://）
                link: 'http://www.baidu.com',
                //副标题文本，'\n'指定换行
                subtext: 'www.baidu.com',
                //副标题文本超链接，也可内链（不加http://）
                sublink: 'http://www.baidu.com',
                //标题水平安放位置，默认为左侧，可选为：'center' | 'left' | 'right' | {number}（x坐标，单位px）
                x: 'left',
                //标题垂直安放位置，默认为全图顶端，可选为：'top' | 'bottom' | 'center' | {number}（y坐标，单位px）
                y: 'top'
            },
            //提示框，鼠标悬浮交互时的信息提示
            tooltip: {
                //触发类型，默认（'item'）数据触发，可选为：'item' | 'axis'
                trigger: 'item'
            },
            //图例，每个图表最多仅有一个图例
            legend: {
                //显示策略，可选为：true（显示） | false（隐藏），默认值为true
                show: true,
                //水平安放位置，默认为全图居中，可选为：'center' | 'left' | 'right' | {number}（x坐标，单位px）
                x: 'center',
                //垂直安放位置，默认为全图顶端，可选为：'top' | 'bottom' | 'center' | {number}（y坐标，单位px）
                y: 'top',
                //legend的data: 用于设置图例，data内的字符串数组需要与sereis数组内每一个series的name值对应
                data:['销量','存货']
            },
            //工具箱，每个图表最多仅有一个工具箱，显示在图表上方，显示为一排多个工具图标
            toolbox:{
                //显示策略，可选为：true（显示） | false（隐藏），默认值为false
                show: true,
                //启用功能，目前支持feature，工具箱自定义功能回调处理
                feature: {
                    //辅助线标志
                    mark: {show: true},
                    //dataZoom，框选区域缩放，自动与存在的dataZoom控件同步，分别是启用，缩放后退
                    dataZoom: {
                        show: true,
                        title: {
                            dataZoom: '区域缩放',
                            dataZoomReset: '区域缩放后退'
                        }
                    },
                    //数据视图，打开数据视图，可设置更多属性,readOnly 默认数据视图为只读(即值为true)，可指定readOnly为false打开编辑功能
                    dataView: {show: true, readOnly: false},
                    //magicType，动态类型切换，支持直角系下的折线图、柱状图、堆积、平铺转换
                    magicType: {show: true, type: ['line', 'bar']},
                    //restore，还原，复位原始图表
                    restore: {show: true},
                    //saveAsImage，保存成图片（IE8-不支持）,图片类型默认为'png'
                    saveAsImage: {show: true}
                }
            },
            //是否启用拖拽重计算特性，默认关闭(即值为false) ??
            calculable: false,
            //直角坐标系中横轴数组，数组中每一项代表一条横轴坐标轴，仅有一条时可省略数值
            //横轴通常为类目型，但条形图时则横轴为数值型，散点图时则横纵均为数值型
            xAxis: {
                //显示策略，可选为：true（显示） | false（隐藏），默认值为true
                show: true,
                //坐标轴类型，横轴默认为类目型'category'
                type: 'category',
                data: ["衬衫","羊毛衫","雪纺衫","裤子","高跟鞋"]
            },
            //直角坐标系中纵轴数组，数组中每一项代表一条纵轴坐标轴，仅有一条时可省略数值
            //纵轴通常为数值型，但条形图时则纵轴为类目型
            yAxis: {
                //显示策略，可选为：true（显示） | false（隐藏），默认值为true
                show: true,
                //坐标轴类型，纵轴默认为数值型'value'
                type: 'value',
                //分隔区域(间隔阴影行)，默认不显示
                splitArea: {show: false}
            },
            //sereis的数据: 用于设置图表数据之用。series是一个对象嵌套的结构；对象内包含对象
            series: [{
                //系列名称，如果启用legend，该值将被legend.data索引相关
                name: '销量',
                //图表类型，必要参数！如为空或不支持类型，则该系列数据不被显示。
                type: 'bar',
                //系列中的数据内容数组，折线图以及柱状图时数组长度等于所使用类目轴文本标签数组axis.data的长度，并且他们间是一一对应的。数组项通常为数值
                data: [5, 20, 36, 10, 15],
                //系列中的数据标注内容
                markPoint: {
                    data: [
                        {type: 'max', name: '最大值'},
                        {type: 'min', name: '最小值'}
                    ],
                    symbolSize: 20, // 标注大小，半宽（半径）参数，当图形为方向或菱形则总宽度为symbolSize * 2
                    itemStyle: {
                        normal: {
                            borderColor: '#87cefa',
                            borderWidth: 1,            // 标注边线线宽，单位px，默认为1
                            label: {
                                show: false
                            }
                        },
                    }
                },
                //系列中的数据标线内容
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
        // 使用刚指定的配置项和数据显示图表,为echarts对象加载数据
        myChart.setOption(option);

    </script>
</body>
</html>

