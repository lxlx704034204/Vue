<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath()+"/";
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<html>
<head>
    <base href="<%=basePath%>">

</head>

<body>
<h2>Hello World!</h2>
<a href="vue">Vue基本尝试</a>
<a href="findall">Vue对象列表</a>
<a href="element">element-ui基本尝试</a>
<a href="map">高德地图-地理编码</a>
<a href="map2">高德地图-js关键词查询</a>
<a href="map3">高德地图+Layui</a>
<a href="layui">Layui</a>
<a href="layui2">Layui_tab</a>
<a href="layui_select">Layui_select</a>
<a href="liandong">element-ui省级联动</a>
<a href="elements">element布局</a>
<br/>
<br/>
<a href="elements2">element table</a>
<a href="elements3">element form</a>
<a href="element_button">element_button</a>
<a href="echarts">echarts 柱状图</a>
<a href="echarts_jianhua">echarts 柱状图(例子)</a>
<a href="echarts2">echarts 饼图</a>
<a href="echarts3">echarts 折线图</a>
<a href="echarts3_lizi">echarts 折线图(例子)</a>
<h1><%=basePath%></h1>

</body>
</html>
