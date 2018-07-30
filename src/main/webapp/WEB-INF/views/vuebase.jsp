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
    <script type=text/javascript src="js/vue.js"></script>
</head>
<body>

<div><%=basePath%></div>
<div><%=path%></div>
<br/>
<!-- 文本赋值   -->
<div id="app">
    <div v-once>{{ message}}</div>
    <div>{{ message+3}}</div>
    <div>{{ message.length>0 ? 'YES' : 'NO' }}</div>
    <div>{{ message.split('').reverse().join('') }}</div>
</div>
<br/>

<!-- 绑定元素特性  -->
<div id="app-2">
    <span v-bind:title="message">
    鼠标悬停几秒钟
    </span>
</div>
<br/>

<!-- if语句   -->
<div id="app-3">
    <p v-if="see">看到了</p>  <!--  see可为任意值，仅作为一个标志    -->
</div>
<br/>

<!-- for循环   -->
<div id="app-4">
    <dl> <!-- ul无序点，ol有序编号，dl自定义空   -->
        <dt v-for="todo in todos"> <!--  app4.todos.push({ text: '新项目' })  -->
            {{todo.text}}
        </dt>
    </dl>
</div>
<br/>

<!-- v-on指令用于监听 DOM 事件，事件监听器,点击事件-->
<div id="app-5">
    <p>{{message}}</p>
    <button v-on:click="reverseMessage">逆转消息</button>
    <button @click="reverseMessage">逆转消息</button> <!--简写-->
</div>
<br/>

<!-- 获取输入值   -->
<div id="app-6">
    <p>{{message}}</p>
    <input v-model="message"/>
</div>
<br/>

<!--v-bind接收参数，动态替换html网页属性值-->
<div id="app-7">
    <p>{{backgroundColor}}</p>
    <input type=button v-bind:style="backgroundColor" value="按钮" />
    <input type=button :style="backgroundColor" value="按钮" />   <!--简写-->
</div>
<br/>

<div id = "app-8">
    千米 : <input type = "text" v-model = "kilometers">
    米 : <input type = "text" v-model = "meters">
</div>
<p id="info"></p>
<br/>

<div id="app-9">{{ fullName }}</div>
<p id="infos"></p>



<script>
    var app = new Vue({
        el:'#app',
        data:{
            message:'Hello Vue!!!'
        }
    })

    var app2 = new Vue({
        el:'#app-2',
        data:{
            message:'页面加载于'+new Date().toLocaleString()
        }
    })

    var app3 = new Vue({
        el:'#app-3',
        data:{
            see:true
        }
    })

    var app4 = new Vue({
        el:'#app-4',
        data:{
            todos:[
                {text:'学习1'},
                {text:'学习2'},
                {text:'学习3'}
            ]
        }
    })

    //method和computed,都可以实现同一个功能，
    // 区别是：method是每次都会重新执行函数，
    // 而computed，只会执行函数一次，只有在它的相关依赖发生改变时才会重新执行函数求值，否则就取上一次的执行结果缓存。
    var app5 = new Vue({
        el:'#app-5',
        data:{
            message:'Hello Vue.js!'
        },
        methods:{ //定义方法
            reverseMessage:function(){
                this.message = this.message.split('').reverse().join('')
                /* split('')以''隔断，把一个字符串为分割成字符串数组   */
                /* reverse() 方法用于颠倒数组中元素的顺序。*/
                /* join('')把数组中的所有元素转换为一个字符串，元素之间的分隔符为'' */
            }
        }
        // computed:{ //计算属性
        //     reverseMessage:function(){
        //         this.message = this.message.split('').reverse().join('')
        //     }
        // }
    })

    var app6 = new Vue({
        el:'#app-6',
        data:{
            message:'Hello Vue!'
        }
    })

    var app7 = new Vue({
        el:'#app-7',
        data:{
            backgroundColor:'background:#ffba3d'
        }
    })

    //当有一些数据需要随着其他数据变动而变动时，容易滥用watch，通常最好的做法是使用计算属性实现。
    //当需要在数据变化时执行异步或者开销较大的操作时，watch方式最有用。
    var app8 = new Vue({
        el: '#app-8',
        data: {
            kilometers : 0,
            meters:0
        },
        methods:{
        },
        computed :{
        },
        watch :{
            kilometers:function(val) {
                this.kilometers = val;
                this.meters = val * 1000;
            },
            meters : function (val) {
                this.kilometers = val/ 1000;
                this.meters = val;
            }
        }
    })
    // $watch 是一个实例方法
    app8.$watch('kilometers', function (newValue, oldValue) {
        // 这个回调将在 app8.kilometers 改变后调用
        document.getElementById ("info").innerHTML = "修改前值为: " + oldValue + "，修改后值为: " + newValue;
    })

    var app9 = new Vue({
        el: '#app-9',
        data: {
            firstName: 'Foo',
            lastName: 'Bar'
        },
        computed: {
            //当你读取一个变量的时候会触发该变量的getter;当你修改该变量时候会触发他的setter.
            fullName: {
                // getter
                get: function () {
                    return this.firstName + ' ' + this.lastName
                },
                // setter
                set: function (newValue) {
                    var names = newValue.split('')
                    this.firstName = names[0]
                    this.lastName = names[names.length - 1]
                }
            }
        }
    })
    //app9.fullName = 'John Doe' //修改时调用app9的setter

</script>


</body>
</html>
