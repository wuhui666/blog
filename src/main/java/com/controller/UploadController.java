package com.controller;

import com.alibaba.fastjson.JSON;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.PageContext;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * @author: wuhui
 * @time: 2019/4/1 10:23
 * @desc:
 */
@Controller
public class UploadController {

    @RequestMapping("/admin/uploadImg")
    @ResponseBody
    public String uploadImg(MultipartFile image_name, HttpServletRequest request){

        if (image_name==null) {
            System.out.println("it is null");
        }
        if (image_name.getSize()<=0) {
            System.out.println("it is empty");

        }
        SimpleDateFormat smf=new SimpleDateFormat("yyyyMMddHHmmss");
        String name=smf.format(new Date())+"@"+image_name.getOriginalFilename();
        System.out.println(name);

        String url= request.getContextPath()+"/static/img/article/"+name;

        System.out.println(url);
        File file=new File(request.getServletContext().getRealPath("/static/img/article"),name);
        if (!file.exists()) {
           file.mkdirs();
            try {
                file.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        HashMap<String , String> jsonMap = new HashMap<>();
        try {
            System.out.println("try..........");

            image_name.transferTo(file);


            jsonMap.put("link", url);

        } catch (IOException e) {
            System.out.println("io exception");
            e.printStackTrace();
        }
        System.out.println(JSON.toJSONString(jsonMap));

        return  JSON.toJSONString(jsonMap);

    }
    @RequestMapping("/admin/uploadVideo")
    @ResponseBody
    public String uploadVideo(MultipartFile video_name,HttpServletRequest request){
        if (video_name==null) {
            System.out.println("it is null");
        }
        if (video_name.getSize()<=0) {
            System.out.println("it is empty");

        }

        System.out.println("in............");
        SimpleDateFormat smf=new SimpleDateFormat("yyyyMMddHHmmss");
        String name=smf.format(new Date())+"@"+video_name.getOriginalFilename();
        System.out.println(name);

        String url= request.getContextPath()+"/static/videos/"+name;

        System.out.println(url);
        File file=new File(request.getServletContext().getRealPath("/static/videos"),name);
        if (!file.exists()) {
            file.mkdirs();
            try {
                file.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        HashMap<String , String> jsonMap = new HashMap<>();
        try {
            System.out.println("try..........");

            video_name.transferTo(file);


            jsonMap.put("link", url);

        } catch (IOException e) {
            System.out.println("io exception");
            e.printStackTrace();
        }
        System.out.println(JSON.toJSONString(jsonMap));

        return  JSON.toJSONString(jsonMap);
    }
    @RequestMapping("/admin/uploadFile")
    @ResponseBody
    public String uploadFile(MultipartFile file_name,HttpServletRequest request){
        if (file_name==null) {
            System.out.println("it is null");
        }
        if (file_name.getSize()<=0) {
            System.out.println("it is empty");

        }


        SimpleDateFormat smf=new SimpleDateFormat("yyyyMMddHHmmss");
        String name=smf.format(new Date())+"@"+file_name.getOriginalFilename();
        System.out.println(name);

        String url= request.getContextPath()+"/static/files/"+name;

        System.out.println(url);
        File file=new File(request.getServletContext().getRealPath("/static/files"),name);
        if (!file.exists()) {
            file.mkdirs();
            try {
                file.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        HashMap<String , String> jsonMap = new HashMap<>();
        try {

            file_name.transferTo(file);


            jsonMap.put("link", url);

        } catch (IOException e) {
            System.out.println("io exception");
            e.printStackTrace();
        }
        System.out.println(JSON.toJSONString(jsonMap));

        return  JSON.toJSONString(jsonMap);
    }
}
