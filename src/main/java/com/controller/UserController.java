package com.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.pojo.Result;
import com.pojo.User;
import com.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

/**
 * @author: wuhui
 * @time: 2019/4/2 21:21
 * @desc:
 */
@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    UserService userService;
    @RequestMapping(value = "/register",produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String toRegisterPage(
            @RequestParam(required = false,value = "photo") MultipartFile file, String username,
            String email, String password, HttpServletRequest request,
            @RequestParam(required = false) String description){
        User user=new User();
        user.setEmail(email);
        user.setPassword(password);
        user.setUsername(username);
        if(description!=null){
            user.setDescription(description);
        }

        if (!file.isEmpty()){

            SimpleDateFormat smf=new SimpleDateFormat("yyyyMMddHHmmss");
            String origin=file.getOriginalFilename();
            String name=smf.format(new Date())+origin.substring(origin.lastIndexOf("."), origin.length());

            //获取tomcat的webapp目录
            String webapp_path = request.getSession().getServletContext().getRealPath("");

            webapp_path= webapp_path.substring(0,webapp_path.lastIndexOf(File.separator));

            String url= "/blog_upload/img/user/"+name;

            File file_new=new File(webapp_path+url);
            if (!file_new.exists()) {
                file_new.mkdirs();
                try {
                    file_new.createNewFile();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            try {
                file.transferTo(file_new);
                //记录头像路径
                user.setPhoto("/blog_upload/img/user/"+name);

            } catch (IOException e) {
                System.out.println("io exception");
                e.printStackTrace();
            }

        }
        userService.insert(user);
        return JSON.toJSONString("注册成功，请登录");
    }
    @RequestMapping(value = "/login",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String login(@RequestBody String data, HttpSession session){

        JSONObject jsonObject= JSON.parseObject(data);
        String email=jsonObject.getString("email");
        String password=jsonObject.getString("password");

        if (email==null){

            return JSON.toJSONString(Result.failure("邮箱为空"));
        }
        if (!email.matches("^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$")){
            return JSON.toJSONString(Result.failure("邮箱格式有误"));

        }
        if (password==null){

            return JSON.toJSONString(Result.failure("密码为空"));
        }
        User user=userService.getUserByEmailAndPassword(email,password);
        if (user==null){

            return JSON.toJSONString(Result.failure("用户名或密码错误"));
        }
        session.setAttribute("currentUser", user);

        if (session.getAttribute("to_url")==null) {

            if (!user.getIsadmin())//普通用户
                return JSON.toJSONString(Result.success().add("to_url","home/1"));
            else
                return JSON.toJSONString(Result.success().add("to_url","admin/home"));
        }
        else {
            String preURL=(String)session.getAttribute("to_url");
            /*delete temporary URL from session*/
            session.removeAttribute("to_url");

            return JSON.toJSONString(Result.success().add("to_url", preURL).add("flag", "true"));
        }

    }
    @RequestMapping("/logout")
    @ResponseBody
    public String logout(HttpSession session){
        session.setAttribute("currentUser", null);
        return JSON.toJSONString("");
    }
    @RequestMapping("/editPage")
    public String editUser(){
        return  "user_edit.jsp";
    }
    @RequestMapping("/edit")
    @ResponseBody
    public String editUser(HttpServletRequest request){
        User user=new User();
        user.setUid(Integer.valueOf(request.getParameter("uid")));
        user.setDescription(request.getParameter("description"));
        user.setEmail(request.getParameter("email"));
        user.setUsername(request.getParameter("username"));
        MultipartFile multipartFile=((MultipartHttpServletRequest)request).getFile("photo");
        if (multipartFile!=null&&!multipartFile.isEmpty()){

            SimpleDateFormat smf=new SimpleDateFormat("yyyyMMddHHmmss");
            String origin=multipartFile.getOriginalFilename();
            String name=smf.format(new Date())+origin.substring(origin.lastIndexOf("."), origin.length());
            //获取tomcat的webapp目录
            String webapp_path = request.getSession().getServletContext().getRealPath("");
            webapp_path= webapp_path.substring(0,webapp_path.lastIndexOf(File.separator));
            System.out.println(webapp_path);
            String url= "/blog_upload/img/user/"+name;
            File file=new File(webapp_path+url);
            if (!file.exists()) {
                file.mkdirs();
                try {
                    file.createNewFile();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            try {

                multipartFile.transferTo(file);
                user.setPhoto("/blog_upload/img/user/"+name);

            } catch (IOException e) {
                System.out.println("io exception");
                e.printStackTrace();
            }
        }

        userService.updateUserSective(user);

        request.getSession().setAttribute("currentUser", userService.getUserByUid(user.getUid()));
        return JSON.toJSONString("hhhhhhh");
    }

    @RequestMapping(value = "/editPassword",produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String editPassword(HttpServletRequest request){
        User user= userService.getUserByUid(Integer.valueOf(request.getParameter("uid")));

        String old_password=request.getParameter("password");
        System.out.println(user.getPassword());
        System.out.println(old_password);
        if (!user.getPassword().equals(old_password)){
            user.setPassword(request.getParameter("new_password"));
            return JSON.toJSONString("原密码错误");
        }

        user.setPassword(request.getParameter("new_password"));
        userService.updateUserSective(user);
        request.getSession().setAttribute("currentUser", null);
        return JSON.toJSONString("密码修改成功,请重新登录");

    }
}
