<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%
    String path = request.getContextPath()+"/";
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>Title</title>
    <link rel="stylesheet" href="js/layui/css/layui.css" media="all">
</head>
<body>

<div class="demoTable">
    搜索ID：
    <div class="layui-inline">
        <input class="layui-input" name="id" id="demoReload" autocomplete="off">
    </div>
    <button class="layui-btn" data-type="reload">搜索</button>
</div>

<table class="layui-hide" id="test" lay-filter="demo"></table>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script type=text/javascript src="js/jquery.js"></script>
<script src="js/layui/layui.js" charset="utf-8"></script>
<script>
    layui.use(['table','jquery'], function () {  //必须先加载'jquery'代码块，要不后面会找不到$
        var table = layui.table;
        var $ = layui.$ //重点处

        //学生表信息
        // table.render({
        //     elem: '#test'
        //     ,url:'/findalls'
        //     ,method:"post"
        //     //,page:true
        //     ,cellMinWidth: 80 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
        //     ,cols: [[
        //         {field:'sid', width:80, title: 'ID', sort: true}
        //         ,{field:'sname', width:100, title: '姓名',edit:true}
        //         ,{field:'age', width:100, title: '年龄', sort: true}
        //     ]]
        //     ,initSort: {
        //         field: 'sid' //排序字段，对应 cols 设定的各字段名
        //         ,type: 'asc' //排序方式  asc: 升序、desc: 降序、null: 默认排序
        //     }
        // });

        //地图信息
        table.render({
            elem: '#test'
            , url: 'locationall'  //用get请求才可自动拼接page等参数
            // , method: "post"
            , cellMinWidth: 80 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
            , cols: [[
                { type: 'numbers', title: '序号' } //系统自带序号列
                , {field: 'placename', width: 200, title: '地名', sort: true}
                , {field: 'address', width: 230, title: '地址', edit: true}
                , {field: 'province', width: 100, title: '省份', sort: true}
                , {field: 'provincecode', width: 100, title: '省份编码', sort: true}
                , {field: 'city', width: 100, title: '城市', sort: true}
                , {field: 'citycode', width: 100, title: '城市编码', sort: true}
                , {field: 'district', width: 100, title: '区县', sort: true}
                , {field: 'districtcode', width: 100, title: '区县编码', sort: true}
                , {field: 'lngandlat', width: 200, title: '坐标', sort: true}
                , {fixed: 'right', width: 165, align: 'center', toolbar: '#barDemo'}
            ]]
            //没有url赋值时，才能显示data的值
            // ,data: [{
            //     "placename": "1"
            //     ,"address": "1"
            //     ,"province": "1"
            //     ,"provincecode": "1"
            //     ,"city": "1"
            //     ,"citycode": "1"
            //     ,"district": "1"
            //     ,"districtcode": "1"
            //     ,"lngandlat": "1"
            // }]
            , even: true  //阴影间隔
            , page: true
            , page: { //分页设定
                layout: ['count', 'prev', 'page', 'next'] //自定义分页布局
                , curr: 1 //设定初始在第 1 页
                , limit: 10//每页多少数据
                , groups: 5 //只显示 5 个连续页码
            }
            , id: 'testReload'
        });

        $('.demoTable .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });

        active = {
            reload: function(){
                var demoReload = $('#demoReload');
                //执行重载
                table.reload('testReload', {
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    ,where: {
                        key:  demoReload.val()  //参数key自动拼接到get地址上，传到了后台
                    }
                });
            }
        };

        // layui.use('laypage', function () {
        //     var laypage = layui.laypage;
        //
        //     //执行一个laypage实例
        //     laypage.render({
        //         elem: 'test1' //注意，这里的 test1 是 ID，不用加 # 号
        //         , limit: 10
        //         // ,count: 50 //数据总数，从服务端得到
        //     });
        // });

        //监听工具条
        table.on('tool(demo)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                , layEvent = obj.event; //获得 lay-event 对应的值
            if (layEvent === 'detail') {
                layer.msg('查看操作');
            } else if (layEvent === 'del') {
                layer.confirm('真的删除行么', function (index) {
                    obj.del(); //删除对应行（tr）的DOM结构
                    layer.close(index);
                    //向服务端发送删除指令
                });
            } else if (layEvent === 'edit') {
                layer.msg('编辑操作');
            }
        });
    });
</script>
</body>
</html>
