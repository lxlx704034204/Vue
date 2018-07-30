package com.example.utils;

import sun.net.ftp.FtpClient;
import sun.net.ftp.FtpProtocolException;

import java.io.*;
import java.net.InetSocketAddress;
import java.net.SocketAddress;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;


/**
 * 获取远程ftp上的文件内容
 */
public class FtpUtil {

    FtpClient ftpClient;

    //连接ftp
    public static FtpClient connectFTP(String url, int port, String username, String password) {
        //创建ftp
        FtpClient ftp = null;
        try {
            //创建地址
            SocketAddress addr = new InetSocketAddress(url, port);
            //连接
            ftp = FtpClient.create();
            ftp.connect(addr);
            //登陆
            ftp.login(username, password.toCharArray());
            ftp.setBinaryType();
        } catch (FtpProtocolException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return ftp;
    }

    //获取文件内容List
    public static List<String> readFile(String ftpFile, FtpClient ftp) {
        List<String> list = new ArrayList<String>();
        String str = "";
        InputStream is = null;
        BufferedReader br = null;
        try {
            // 获取ftp上的文件
            is = ftp.getFileStream(ftpFile);
            //转为字节流
            br = new BufferedReader(new InputStreamReader(is));
            while((str=br.readLine())!=null){
                list.add(str);
            }
            br.close();
        }catch (FtpProtocolException e) {
            e.printStackTrace();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return list;
    }

    //返回获取到的文件内容String
    public String getFileContent(){
        FtpClient ftp = connectFTP("120.77.207.46",1212,"zl","zl@chkj");
        List<String> fileList = readFile("error.log",ftp); //获取文件内容
        List<String> fileList2 = new ArrayList<String>();
        String fileContent = "";

        //最多展示3000行
        if(fileList.size()<=3000){
            for(int i=0;i<fileList.size();i++){
                fileContent+=fileList.get(i)+"\r\n";
            }
        }else{
            for(int j=fileList.size();fileList.size()-j<=3000;j--){
                fileList2.add(fileList.get(j-1));
            }
            Collections.reverse(fileList2); //反转list
            for(int i=0;i<fileList2.size();i++){
                fileContent+=fileList2.get(i)+"\r\n";
            }
        }

        //将读取到的内容写进新文件保存
        String fileContent2 = "";
        try { // 防止文件建立或读取失败，用catch捕捉错误并打印，也可以throw
            if(fileList.size()>0) {
                /* 写入Txt文件 */
                File writename = new File("C:\\Users\\chad\\Desktop\\Idea\\ServerSends\\src.\\readlog.txt"); // 相对路径，如果没有则建立一个新的output。txt文件
                writename.createNewFile(); // 创建新文件
                BufferedWriter out = new BufferedWriter(new FileWriter(writename)); //每次都覆盖
                out.write(fileContent); // \r\n即为换行
                out.flush(); // 把缓存区内容压入文件
                out.close(); // 最后关闭文件
            }

            /* 读入TXT文件(如果这一次没有获取到文件内容，那就默认读取上一次的备份文件) */
            String pathname = "C:\\Users\\chad\\Desktop\\Idea\\ServerSends\\src.\\readlog.txt"; // 绝对路径或相对路径都可以，这里是绝对路径，写入文件时演示相对路径
            File filename = new File(pathname); // 要读取以上路径的input。txt文件
            InputStreamReader reader = new InputStreamReader(new FileInputStream(filename)); // 建立一个输入流对象reader
            BufferedReader br = new BufferedReader(reader); // 建立一个对象，它把文件内容转成计算机能读懂的语言
            String line = br.readLine();
            while (line != null) {
                line = br.readLine(); // 一次读入一行数据
                if(line!=null){
                    fileContent2 += line+"\r\n";//换行必须有
                }
            }
        }catch (Exception e) {
            e.printStackTrace();
        }

        try {
            ftp.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return fileContent2;
    }
}
