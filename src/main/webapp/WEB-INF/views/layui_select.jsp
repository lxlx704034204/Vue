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

<form class="layui-form" action="">
    <div class="layui-form-item proSelect">
        <label class="layui-form-label">产品类别</label>
        <div class="layui-input-block editWidth">
            <select name="productList" lay-verify="required" id="zcySelect">
                <option value=""></option>
                <option value="0">轻松融</option>
                <option value="1">容易融</option>
                <option value="2">快乐融</option>
            </select>
        </div>
    </div>
    <a class="layui-btn layui-btn-small" id="" onclick="addProductClassify()">增加产品类别</a>
</form>
<!--弹窗内容-->
<div id="select_prod" class="layui-form" hidden="hidden">
    <div class="layui-input-inline">
        <input type="text" name="text" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
    </div>
</div>


<script type=text/javascript src="js/jquery.js"></script>
<script src="js/layui/layui.js" charset="utf-8"></script>
<script>
    layui.use(['table','jquery','layer'], function () {  //必须先加载'jquery'代码块，要不后面会找不到$
        var table = layui.table;
        var $ = layui.$ //重点处
        var layer = layui.layer;


    });

    //重新渲染表单
    function renderForm(){
        layui.use(['form','layer'], function(){
            var form = layui.form;//高版本建议把括号去掉，有的低版本，需要加()
            form.render();
        });
    }
    //增加产品类别按钮点击事件
    function addProductClassify(){
        $("#zcySelect").append("<option value="+20+">"+'asd'+"</option>");
        renderForm();//表单重新渲染，要不然添加完显示不出来新的option

        // layer.open({
        //     type:1,
        //     btn:['确定','取消'],
        //     content:$("#select_prod"),
        //     area:['270px','160px'],
        //     //当前层索引参数（index）、当前层的DOM对象（layero）
        //     yes:function(index,layero){
        //         //获取input输入的值
        //         var ivalue=$(layero).find("input").val();
        //         //获取要添加的option的索引
        //         var sIndex=$("#zcySelect")[0].options.length-1;
        //         if(ivalue==null||ivalue==''){
        //             layer.msg("请输入产品类别")
        //         }
        //         else{
        //             layer.msg("输入的产品类别是："+ivalue);
        //             //为select添加option
        //             $("#zcySelect").append("<option value="+sIndex+">"+ivalue+"</option>");
        //             renderForm();//表单重新渲染，要不然添加完显示不出来新的option
        //             layer.close(index);
        //         }
        //         $(layero).find("input").val('');
        //     }
        // })
    }



    //选中显示一个option(param为入参)-方法1
    // var select = 'dd[lay-value=' + param + ']';
    // $('#companyCodes').siblings("div.layui-form-select").find('dl').find(select).click();
    // console.log("下拉框选中项:" + $('select').val())
    // //如果入参失败，则刷新页面
    // if($('select').val()=="" || $('select').val()==null){
    //     window.location.reload();
    // }

    //选中显示一个option(param为入参)-方法2
    // $('select').val(param); //下拉框选中项。$()中要用单引号
    // console.log("下拉框选中项:" + $('select').val())
    // form.render(); //加载下拉框
    // if($('select').val()=="" || $('select').val()==null){
    //     console.log("刷新:"+param)
    //     window.location.reload();
    // }


</script>
</body>
</html>
