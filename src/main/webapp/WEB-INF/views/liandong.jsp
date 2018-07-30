<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath()+"/";
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>element-ui省市县三级联动菜单代码</title>
    <link rel="stylesheet" href="js/shengshiliandong/plugins/eleme-ui/index.css"/>
</head>
<body>

<div id="myVue"><br>
    <el-form ref="form" :model="form" label-width="100px">
        <el-form-item label="">
            一.此地区插件基于element-ui编写
        </el-form-item>
        <el-form-item label="">
            二.此地区插件功能如下：1.可以查询搜索 2.可以清楚输入框内的记录
        </el-form-item>
        <el-form-item label="所在地区：">
            <el-cascader
                    :options="CityInfo"
                    v-model="form.selectedOptions"
                    :change-on-select="true"
                    :clearable="true"
                    :filterable="true"
                    @change="handleChange">
            </el-cascader>
            <span id ="all" onclick="bb()">所选地区：{{form.city | myAddressCity}}{{form.erae | myAddressErae}}{{form.minerae | myAddressMinerae}}</span>
        </el-form-item>
    </el-form>
</div>
<%--<input id="a" value="1"/>--%>
<!--js类引用-->
<script type="text/javascript" src="js/shengshiliandong/plugins/vue/vue.min.js"></script>
<script type="text/javascript" src="js/shengshiliandong/plugins/eleme-ui/index.js"></script>
<script type="text/javascript" src="js/shengshiliandong/plugins/city-picker/city-data-json.js"></script>
<script type="text/javascript" src="js/shengshiliandong/CivilMilitaryIntegration/ShoppingCart.js"></script>

<script type=text/javascript src="js/jquery.js"></script>
<script>
    function bb(){
        var aaa = $("#all").text();
        // var s = document.getElementById("all").value;
        alert(aaa)
    }
</script>

</body>
</html>
