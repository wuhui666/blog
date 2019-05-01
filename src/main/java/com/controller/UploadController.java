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
        String origin=image_name.getOriginalFilename();
        String name=smf.format(new Date())+origin.substring(origin.lastIndexOf("."), origin.length());

        //获取tomcat的webapp目录
        String webapp_path = request.getSession().getServletContext().getRealPath("");
        webapp_path= webapp_path.substring(0,webapp_path.lastIndexOf(File.separator));//别用斜杆


        String url= "/blog_upload/img/article/"+name;

        File file=new File(webapp_path+url);
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
        SimpleDateFormat smf=new SimpleDateFormat("yyyyMMddHHmmss");
        String origin=video_name.getOriginalFilename();
        String name=smf.format(new Date())+origin.substring(origin.lastIndexOf("."), origin.length());

        //获取tomcat的webapp目录
        String webapp_path = request.getSession().getServletContext().getRealPath("");

        webapp_path= webapp_path.substring(0,webapp_path.lastIndexOf(File.separator));

        String url= "/blog_upload/video/"+name;

        File file=new File(webapp_path+url);
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
        String origin=file_name.getOriginalFilename();
        String name=smf.format(new Date())+origin.substring(origin.lastIndexOf("."), origin.length());

        //获取tomcat的webapp目录
        String webapp_path = request.getSession().getServletContext().getRealPath("");

        webapp_path= webapp_path.substring(0,webapp_path.lastIndexOf(File.separator));

        String url= "/blog_upload/file/"+name;

        File file=new File(webapp_path+url);
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
