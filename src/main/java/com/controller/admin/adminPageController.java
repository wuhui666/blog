package com.controller.admin;

import com.pojo.User;
import com.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

/**
 * @author: wuhui
 * @time: 2019/3/28 14:26
 * @desc:
 */
@Controller
public class adminPageController {

    @Autowired
    UserService userService;

    @RequestMapping("/admin/login")
    public String toLogin(){
        return "login.jsp";
    }

    @RequestMapping("/admin")
    public String adminHome(String email, String password, HttpSession session){

        if (email==null){
            return "login.jsp";
        }
        if (password==null){
            return "login.jsp";
        }
        if (!email.matches("^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$")){
            return "login.jsp";
        }
        User user=userService.getUserByEmailAndPassword(email,password);

        if (user==null){
            return "login.jsp";
        }
        if (!user.getIsadmin()){
            return "login.jsp";
        }
        session.setAttribute("currentUser", user);
        return "redirect:admin/home";
    }
    @RequestMapping("/admin/home")
    public String toAdminHomePage(){
        return  "admin/home.jsp";
    }


}
