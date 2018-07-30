package com.example.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Date;

public class webUtils {
    //执行bat
    public static int runCmd(String command){
        Runtime runtime = Runtime.getRuntime();
        Process pro = null;
        try {
            //该对象的exec()方法指示Java虚拟机创建一个子进程执行指定的可执行程序，并返回与该子进程对应的Process对象实例。
            pro = runtime.exec(command);
            System.out.println("程序运行中...");
            pro.waitFor(); //等待子进程完成再往下执行。

            BufferedReader br = new BufferedReader(new InputStreamReader(pro
                    .getInputStream(),"GBK")); //虽然cmd命令可以直接输出，但是通过IO流技术可以保证对数据进行一个缓冲。
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
        return i;
    }

    //获取当前时间
    public static String getCurrentTime() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        return sdf.format(new Date());
    }
}
