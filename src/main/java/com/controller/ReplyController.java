package com.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.pojo.Reply;
import com.pojo.Result;
import com.service.ReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;

/**
 * @author: wuhui
 * @time: 2019/4/6 18:43
 * @desc:
 */
@Controller
@RequestMapping("/reply")
public class ReplyController {
    @Autowired
    ReplyService replyService;

    @RequestMapping(value = "/add",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String addReply(@RequestBody String reply){
        JSONObject jsonObject=JSON.parseObject(reply);
        String to_name=jsonObject.getString("content").split(" ")[0];

        String to_user_name=jsonObject.getString("to_user_name");
        System.out.println(to_name+"-----"+to_user_name);
        Reply newReply=jsonObject.toJavaObject(Reply.class);
        newReply.setCreateTime(new Date());
        newReply.setType("0");
        if (jsonObject.getString("toUid")!=null&&to_user_name.equals(to_name)){
            newReply.setType("1");
            System.out.println("specific");
        }
        replyService.addReply(newReply);

        return JSON.toJSONString(Result.success());

    }

    @RequestMapping("/delete/{rid}")
    @ResponseBody
    public String deleteReply(@PathVariable Integer rid){
        replyService.deleteReply(rid);
        return JSON.toJSONString("删除成功");
    }
}
