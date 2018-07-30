<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@  taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    String path = request.getContextPath()+"/";
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>Title</title>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <script type=text/javascript src="js/vue.js"></script>
    <script type=text/javascript src="js/jquery.js"></script>
</head>
<body>
    <div>
        <c:forEach items="${list}" var="stu">
            ${stu.sid },${stu.sname },${stu.age }
            &nbsp;<a href="delete.action?sid=${stu.sid }">删除</a> &nbsp;
            <a href="toupdate.action?sid=${stu.sid }">修改</a><br/>
        </c:forEach>
    </div>

    <%--<div id="app">--%>
        <%--&lt;%&ndash;<h1>服务端数据为：{{student}}</h1>&ndash;%&gt;--%>
        <%--<dl> <!-- ul无序点，ol有序编号，dl自定义空   -->--%>
            <%--<dt v-for="todo in myData"> <!--  app4.todos.push({ text: '新项目' })  -->--%>
                <%--{{todo.name}}--%>
            <%--</dt>--%>
        <%--</dl>--%>
    <%--</div>--%>

    <%--<div id="app">--%>

        <%--<div v-for="art in student">--%>
            <%--<span>{{art.sid}}</span>--%>
            <%--<span>{{art.sname}}</span>--%>
            <%--<span>{{art.age}}</span>--%>
        <%--</div>--%>

    <%--</div>--%>

    <script>
    // var app = new Vue({
    //         el:'#app',
    //         data:{
    //             student: ''
    //         },
    //         methods:{
    //             student: function() {
    //                 axios.get('/findById?id=1')
    //                     .then(function (response) {
    //                         this.student = response.data;
    //                     })
    //                     .catch(function (error) {
    //                         console.log(error);
    //                     });
    //
    //             }
    //         }
    //     })


    var myModel = {"userList":[]};
    var myViewModel = new Vue({
        el:'#app',
        data:myModel
    });

    $.ajax({
        url:'http://localhost:8080/findById?id=1',//实现跨域的URL路径 'findById?id=1',
        type:'GET',

        dataType:'json',
        timeout:3000,
        success:function(result){
            console.log(result);
            //myModel.userList = result.userList;
        },
        error:function(XMLHttpRequest, textStatus, errorThrown){
            //alert('服务器忙，请不要说脏话，理论上大家都是文明人');
            console.log(textStatus+XMLHttpRequest.status);
        }
    });

    </script>

</body>


</html>
