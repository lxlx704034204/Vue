import com.example.utils.webUtils;

public class Test1 {
    public static void main(String[] args) {
        //String command = "cmd /c notepad"; //打开记事本
        //String command = "notepad.exe C:\\Users\\chad\\Desktop\\socket.txt";  //用记事本，打开具体文件txt
        //String command = "C:\\c_install\\Notepad++\\notepad++.exe"; //打开notepad++
        //String command ="C:\\Users\\chad\\AppData\\Local\\youdao\\dict\\Application\\YoudaoDict.exe";//打开有道词典
        //String command ="cmd /c calc"; //打开计算器（calc），其他程序指令另查

        //在bat文件内容的最后加上exit,即可实现执行后退出，但黑框还是会自动弹出
        //String command = "cmd /c start C:\\Users\\chad\\Desktop\\bbb.bat";
        //String command = "C:\\Users\\chad\\Desktop\\bbb.bat";   //bat文件内容为@calc.exe

        //利用中介，即java通过调用执行vbs文件来调用cmd执行bat文件，属性设置为隐藏即可,属性0代表隐藏，不显示黑框
        /* vbs文件内容:
         * Set ws = CreateObject("Wscript.Shell")
           ws.run "cmd /c 你的文件名.bat",0
         * */
        //String command = "cmd /c start C:\\Users\\chad\\Desktop\\ccc.vbs";

        //c:\backup\tools里两个文件是备份必须的！！
        //String command="cmd /c start C:\\backup\\tools\\sqlserver_backup.bat"; //备份sqlserver数据库
        //String command="cmd /c start C:\\backup\\tools\\code_backup.bat";//备份文件夹（代码）
        //String command="cmd /c start C:\\backup\\tools\\sqlserver_execute.bat";//执行sql语句

        //直接使用tomcat安装目录下的文件
        //String command="C:\\backup\\tools\\tomcat_start.bat";//启动tomcat  一关黑框就停止
        //String command="C:\\backup\\tools\\tomcat_restart.bat";//重启tomcat
        //String command="cmd /c start C:\\backup\\tools\\tomcat_shop.bat";//停止tomcat

        //将tomcat部署到win服务中
        //String command = "C:\\backup\\tools\\tomcat_win_start.bat"; //启动
        //String command = "C:\\backup\\tools\\tomcat_win_restart.bat";  //重启
        String command = "C:\\backup\\tools\\tomcat_win_stop.bat";   //停止
        int i = 1;
        if (command != null) {
            System.out.println("windows服务监控器--------" + webUtils.getCurrentTime() + "----------->" + command);
            i = webUtils.runCmd(command);
        }
        System.out.println(i);


    }

}
