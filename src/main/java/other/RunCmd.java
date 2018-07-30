package other;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Date;

public class RunCmd {
    public static void main(String[] args) {
        //String command = "cmd /c notepad"; //打开记事本
        //String command = "notepad.exe C:\\Users\\chad\\Desktop\\socket.txt";  //用记事本，打开具体文件txt
        //String command = "C:\\c_install\\Notepad++\\notepad++.exe"; //打开notepad++
        //String command = "C:\\Users\\chad\\AppData\\Local\\youdao\\dict\\Application\\YoudaoDict.exe";//打开有道词典
        //String command = "cmd /c calc"; //打开计算器（calc），其他程序指令另查

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
        String command="cmd /c start C:\\backup\\tools\\backup.bat";
        runCmd(command);
    }

    //执行bat
    public static void runCmd(String command){
        Runtime runtime = Runtime.getRuntime();
        Process pro = null;
        try {
            //该对象的exec()方法指示Java虚拟机创建一个子进程执行指定的可执行程序，并返回与该子进程对应的Process对象实例。
            pro = runtime.exec(command);
            pro.waitFor(); //等待子进程完成再往下执行。

            BufferedReader br = new BufferedReader(new InputStreamReader(pro
                    .getInputStream())); //虽然cmd命令可以直接输出，但是通过IO流技术可以保证对数据进行一个缓冲。
            String msg = null;
            while ((msg = br.readLine()) != null) {
                System.out.println(msg);
            }
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("IOException！");
        } catch (InterruptedException e) {
            e.printStackTrace();
            System.out.println("InterruptedException！");
        }

        int i = pro.exitValue();  //接收执行完毕的返回值
        if (i == 0) {
            System.out.println("执行完成.");
        } else {
            System.out.println("执行失败.");
        }
        pro.destroy();  //销毁子进程
        pro = null;
    }

    //获取当前时间
    private static String getCurrentTime() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        return sdf.format(new Date());
    }
}
