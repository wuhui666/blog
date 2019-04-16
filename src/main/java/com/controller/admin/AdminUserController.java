package com.controller.admin;

import com.github.pagehelper.PageInfo;
import com.pojo.Reply;
import com.service.CommentService;
import com.service.ReplyService;
import com.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author: wuhui
 * @time: 2019/4/14 15:25
 * @desc:
 */
@Controller
@RequestMapping("/admin")
public class AdminUserController {
    @Autowired
    UserService userService;


    @RequestMapping("/manageUser/{num}")
    public String manageUser(@PathVariable("num") Integer startIndex, Model model){

        PageInfo pageInfo=new PageInfo(userService.getAllUser(startIndex),3);
        model.addAttribute("userPageInfo",pageInfo);
        model.addAttribute("partPath","admin/manageUser");
        return "admin/manageUser.jsp";
    }

    @RequestMapping("/deleteUser")
    public String deleteUser(Integer uid,Integer num){
        userService.deleteUserByUid(uid);

        return "redirect:/admin/manageUser/"+num;
    }
}
