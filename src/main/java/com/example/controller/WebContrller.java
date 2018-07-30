package com.example.controller;

import com.example.utils.webUtils;
import com.google.gson.Gson;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class WebContrller {

    @RequestMapping("/element_button")
    public String element_button() {
        return "element_button";
    }

    //返回值i=0，则成功，其他为失败
    @RequestMapping(value="/runcommand",produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String runcommand(
            @RequestParam(value="commandNum",required=true) String commandNum
    ) {
        String command = null;
        if("start".equals(commandNum)){
            command = "C:\\backup\\tools\\tomcat_win_start.bat"; //启动
        }else if("restart".equals(commandNum)){
            command = "C:\\backup\\tools\\tomcat_win_restart.bat"; //重启
        }else if("stop".equals(commandNum)){
            command = "C:\\backup\\tools\\tomcat_win_stop.bat";   //停止
        }

        else if("backup_code".equals(commandNum)){
            command="cmd /c start C:\\backup\\tools\\code_backup.bat";//备份文件夹（代码）
        }else if("backup_sql".equals(commandNum)){
            command="cmd /c start C:\\backup\\tools\\sqlserver_backup.bat"; //备份sqlserver数据库
        }else if("sql_execute".equals(commandNum)){
            command="cmd /c start C:\\backup\\tools\\sqlserver_execute.bat";//执行sql语句
        }

        //String command="cmd /c net stop Tomcat8";
        int i = 1;
        if(command!=null){
            System.out.println("windows服务监控器--------" + webUtils.getCurrentTime() + "----------->" + command);
            i = webUtils.runCmd(command);
        }

        Gson gson = new Gson();
        String s = gson.toJson(i);
        return s;
    }


}
