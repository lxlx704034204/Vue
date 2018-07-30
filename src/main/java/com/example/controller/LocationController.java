package com.example.controller;

import com.example.bean.Location;
import com.example.bean.Student;
import com.example.dao.LocationDao;
import com.google.gson.Gson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Controller
//@RequestMapping("/vue")
public class LocationController {

    private static final Logger log = LoggerFactory.getLogger(StudentController.class);
    private static LocationDao dao = new LocationDao();

    @RequestMapping(value="/locationall",produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String locationAll(int page, int limit){
        log.info("s:"+page+","+limit);
        Map<String,Object> map = new LinkedHashMap<>(); //
        List<Location> list = dao.queryForList();
        map.put("code",0);
        map.put("msg","");
        map.put("count",1000);
        map.put("data",list);

        Gson gson = new Gson();
        String jsonStr = gson.toJson(map);
        //log.info("s:"+s);
        return jsonStr;
    }

    @RequestMapping(value="/addlocation",method = RequestMethod.POST )
    @ResponseBody
    public String addLocation(
            @RequestParam(value="placename",required=true) String placename,
            @RequestParam(value="address",required=true) String address,
            @RequestParam(value="province",required=true) String province,
            @RequestParam(value="provincecode",required=true) String provincecode,
            @RequestParam(value="city",required=true) String city,
            @RequestParam(value="citycode",required=true) String citycode,
            @RequestParam(value="district",required=true) String district,
            @RequestParam(value="districtcode",required=true) String districtcode,
            @RequestParam(value="lngandlat",required=true) String lngandlat
    ){
        Location location = new Location(
                placename,address,province,provincecode,city,citycode,district,districtcode,lngandlat
        );

        int rows = dao.insertData(location);
        Gson gson = new Gson();
        String jsonStr = gson.toJson(rows);
        return jsonStr;
    }


}
