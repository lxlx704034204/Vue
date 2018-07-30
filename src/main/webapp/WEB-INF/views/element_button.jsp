<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath()+"/";
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>nx.ihooy.com:9011</title>
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <style>
        .el-header {
            background: #EBEEF5;
            text-align: center;
            line-height: 60px;
        }
        .el-main {
            text-align: center;
            /*line-height: 430px;*/
            font-size: 15px;
        }
        .el-row {
            margin-bottom: 10px;
        }
        .el-row:last-child {
            margin-bottom: 0;
        }
        .el-col {
            border-radius: 4px;
        }
    </style>
</head>
<body>
<div id="app">
    <el-container>
        <el-header>
            <el-row>
                <%if(0>1){%>
                <el-col :span="6">
                    http://nx.ihooy.com:9011
                </el-col>
                <%}%>
            </el-row>
        </el-header>
        <el-main>
            <el-row type="flex" align="middle">
                <el-col :span="4" align="start">系统重启/停止：</el-col>
                <el-col :span="4" align="start">启动 <el-button size="small" :disabled="num0" @click="btnClick(0)">默认按钮</el-button></el-col>
                <el-col :span="4" align="start">重启 <el-button size="small" :disabled="num1" @click="btnClick(1)">默认按钮</el-button></el-col>
                <el-col :span="4" align="start">停止 <el-button size="small" :disabled="num2" @click="btnClick(2)">默认按钮</el-button></el-col>
            </el-row>
            <el-row  type="flex" align="middle">
                <el-col :span="4" align="start">备份数据库和代码到C:/</el-col>
                <el-col :span="4" align="start">备份数据库 <el-button size="small" :disabled="num3" @click="btnClick(3)">默认按钮</el-button></el-col>
                <el-col :span="4" align="start">备份代码   <el-button size="small" :disabled="num4" @click="btnClick(4)">默认按钮</el-button></el-col>
            </el-row>
            <el-row  type="flex" align="middle">
                <el-col :span="4" align="start">执行sql语句</el-col>
                <el-col :span="4" align="start">执行sql <el-button size="small" :disabled="num5" @click="btnClick(5)">默认按钮</el-button></el-col>
                <el-col :span="12" align="start">注意：需要先将sqlserver_execute.sql文件放到C:/backup文件夹中</el-col>
            </el-row>
        </el-main>
    </el-container>
</div>

<script type=text/javascript src="js/jquery.js"></script>
<!-- import Vue before Element -->
<script src="https://unpkg.com/vue/dist/vue.js"></script>
<!-- import JavaScript -->
<script src="https://unpkg.com/element-ui/lib/index.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script>
    new Vue({
        el: "#app",
        data:{
            num0:false,
            num1:false,
            num2:false,
            num3:false,
            num4:false,
            num5:false
        },
        methods:{
            btnClick:function(n){
                // event 是原生 DOM 事件
                // event.target 是你当前点击的元素
                // event.currentTarget 是你绑定事件的元素
                // event.currentTarget.tagName 是你绑定事件的元素的名称 eg;button
                // this.num = event.currentTarget.getAttribute("num") 获取当前元素属性

                var _this = this;
                if(n==0){
                    alert("启动")
                    this.$options.methods.command("start")

                    _this.num0 = true;
                    setTimeout(function(){
                        _this.num0 = false; //解禁
                    },2000)
                }else if(n==1){
                    alert("重启")
                    this.$options.methods.command("restart")

                    _this.num1 = true;
                    setTimeout(function(){
                        _this.num1 = false; //解禁
                    },2000)
                }else if(n==2){
                    alert("停止")
                    this.$options.methods.command("stop")

                    _this.num2 = true;
                    setTimeout(function(){
                        _this.num2 = false; //解禁
                    },2000)
                }else if(n==3){
                    alert("备份数据库")
                    this.$options.methods.command("backup_sql")

                    _this.num3 = true;
                    setTimeout(function(){
                        _this.num3 = false; //解禁
                    },2000)
                }else if(n==4){
                    alert("备份代码")
                    this.$options.methods.command("backup_code")

                    _this.num4 = true;
                    setTimeout(function(){
                        _this.num4 = false; //解禁
                    },2000)
                }else if(n==5){
                    alert("执行sql")
                    this.$options.methods.command("sql_execute")

                    _this.num5 = true;
                    setTimeout(function(){
                        _this.num5 = false; //解禁
                    },2000)
                }
            },
            command:function(commandkey){
                $.ajax({
                    url:'runcommand',
                    type:'post',
                    data:{"commandNum":commandkey},
                    dataType:'json',
                    success:function(result){
                        alert(result);
                    },
                    error:function(XMLHttpRequest, textStatus, errorThrown){
                        console.log(textStatus+XMLHttpRequest.status);
                    }
                });

                // axios.post('runcommand',{
                //     commandNum:'stop'
                // },{'Content-Type':'application/x-www-form-urlencoded'})
                //     .then(function (res) {
                //         console.log(res);
                //     })
                //     .catch(function (error) {
                //         console.log(error);
                //     });
            }

        }
    })
</script>

</body>
</html>