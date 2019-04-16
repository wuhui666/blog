package com.controller.admin;

import com.github.pagehelper.PageInfo;
import com.pojo.Reply;
import com.service.ReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author: wuhui
 * @time: 2019/4/14 21:04
 * @desc:
 */
@Controller
@RequestMapping("/admin")
public class AdminReplyController {
    @Autowired
    ReplyService replyService;
    
    @RequestMapping("/manageReply/{num}")
    public String manageReply(@PathVariable("num") Integer index, Model model){
        PageInfo pageInfo=new PageInfo(replyService.getAllReply(index),3);
        model.addAttribute("replyPageInfo",pageInfo);
        model.addAttribute("partPath","admin/manageReply");
        return "admin/manageReply.jsp";

    }

    @RequestMapping("/deleteReply")
    public String deleteReply(Integer rid,Integer num){
        replyService.deleteByRid(rid);
        return "redirect:/admin/manageReply/"+num;
    }
    
}
