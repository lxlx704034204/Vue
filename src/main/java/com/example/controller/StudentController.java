package com.example.controller;

import com.example.bean.Student;
import com.example.dao.StudentDao;
import com.google.gson.Gson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.*;

// 注解标注此类为springmvc的controller，url映射为"/home"
@Controller
//@RequestMapping("/vue")
public class StudentController {

    private static final Logger log = LoggerFactory.getLogger(StudentController.class);
    private static StudentDao dao = new StudentDao();

    @RequestMapping("/vue")
    public String index(){
        return "vuebase";
    }
    @RequestMapping("/element_liandong2")
    public String element_liandong2(){
        return "element_liandong2";
    }

    @RequestMapping("/map")
    public String map(){
        return "map";
    }

    @RequestMapping("/map2")
    public String map2(){
        return "map2";
    }

    @RequestMapping("/map3")
    public String map3(){
        return "map3";
    }

    @RequestMapping("/layui")
    public String layui(){
        return "layui";
    }

    @RequestMapping("/layui2")
    public String layui2(){
        return "layui_tab";
    }

    @RequestMapping("/layui_select")
    public String layui_select(){
        return "layui_select";
    }

    @RequestMapping("/element_liandong")
    public String element_liandong(){
        return "element_liandong";
    }

    @RequestMapping("/element_layout")
    public String element_layout(){
        return "element_layout";
    }

    @RequestMapping("/element_table")
    public String element_table(){
        return "element_table";
    }

    @RequestMapping("/element_form")
    public String element_form(){
        return "element_form";
    }

    @RequestMapping("/echarts_jianhua")
    public String echarts_jianhua(){
        return "echarts_jianhua";
    }

    @RequestMapping("/echarts")
    public String echarts(){
        return "echarts";
    }

    @RequestMapping("/echarts2")
    public String echarts2(){
        return "echarts2";
    }

    @RequestMapping("/echarts3")
    public String echarts3(){
        return "echarts3";
    }

    @RequestMapping("/echarts3_lizi")
    public String echarts3_lizi(){
        return "echarts3_lizi";
    }

    @RequestMapping("/findall")
    public ModelAndView findall(){
        List<Student> list = dao.queryForList();
        log.info("list:"+list);
        Map<String,List<Student>> map = new HashMap<String,List<Student>>();
        map.put("list", list);
        return new ModelAndView("showlist",map);
    }

    @RequestMapping(value="/findalll",produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String findalll(){
        List<Student> list = dao.queryForList();
        log.info("list:"+list);

        Gson gson = new Gson();
        String s = gson.toJson(list);
        return s;
    }

    //有分页
    @RequestMapping(value="/findalll2",method = RequestMethod.POST,produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String findalll2(@RequestBody Map map){
        String page = (String)map.get("page");
        String pageSize = (String)map.get("pageSize");

        List<Student> list = dao.queryForList2(Integer.parseInt(page),Integer.parseInt(pageSize));
        log.info("list:"+list);

        int count = dao.queryForList3();

        List allList = new ArrayList();
        allList.add(list);
        allList.add(count);

        Gson gson = new Gson();
        String s = gson.toJson(allList);
        return s;
    }

    @RequestMapping(value="/addstu",method = RequestMethod.POST)
    @ResponseBody
    public int addStu(@RequestBody Map map){
        Student stu = new Student((String)map.get("sid")
                ,(String)map.get("sname"),(String)map.get("age"));
        int rows = dao.insertData(stu);
        return rows;
    }

    @RequestMapping(value="/deletestu",method = RequestMethod.POST)
    @ResponseBody
    public int deleteStu(@RequestBody Map map){
        int rows = dao.deleteData((String)map.get("sid"));
        return rows;
    }

    @RequestMapping(value="/updatestu",method = RequestMethod.POST)
    @ResponseBody
    public int updateStu(@RequestBody Map map){
        Student stu = new Student((String)map.get("sid")
                ,(String)map.get("sname"),(String)map.get("age"));
        int rows = dao.updateData(stu);
        return rows;
    }





    @RequestMapping(value="/findById",method = RequestMethod.POST)
    @ResponseBody
    public Student findById(
            @RequestParam(value="id",required=true) String id
    ){
        Student stu = dao.queryForObject(id);
        return stu;
    }


    //consumes： 指定处理请求的提交内容类型（Content-Type），例如application/json, text/html;
    //produces: 指定返回的内容类型，仅当request请求头中的(Accept)类型中包含该指定类型才返回；
    @RequestMapping(value="/findalls",produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String findalls(){
        Map<String,Object> map = new LinkedHashMap<>(); //
        List<Student> list = dao.queryForList();
        map.put("code",0);
        map.put("msg","");
        map.put("count",1000);
        map.put("data",list);

        Gson gson = new Gson();
        String s = gson.toJson(map);
        //log.info("s:"+s);
        return s;
    }

    @RequestMapping("getStudent")
    public void getStudent(HttpServletRequest req, HttpServletResponse resp){
        try {
            req.setCharacterEncoding("utf-8");
            resp.setContentType("text/html;charset=utf-8");
        } catch (UnsupportedEncodingException e1) {
            e1.printStackTrace();
        }
        String name=req.getParameter("name");
        String sex=req.getParameter("sex");
        byte[] b;
        try {
            b = name.getBytes("ISO-8859-1");
            name=new String(b,"utf-8");
            b = sex.getBytes("ISO-8859-1");
            sex=new String(b,"utf-8");
        } catch (UnsupportedEncodingException e1) {
            e1.printStackTrace();
        }//用tomcat的格式（iso-8859-1）方式去读。

        System.out.println("姓名："+name+"\t性别："+sex);
        try {
            PrintWriter out=resp.getWriter();
            out.print("[{lattice:\"格子\"},{lattice:\"222\"}]");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


}

