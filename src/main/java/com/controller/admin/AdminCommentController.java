package com.controller.admin;

import com.github.pagehelper.PageInfo;
import com.pojo.Article;
import com.pojo.Comment;
import com.pojo.User;
import com.service.ArticleService;
import com.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author: wuhui
 * @time: 2019/4/14 16:32
 * @desc:
 */
@Controller
@RequestMapping("/admin")
public class AdminCommentController {
    @Autowired
    CommentService commentService;
    @Autowired
    ArticleService articleService;

    @RequestMapping("/manageComment/{num}")
    public String manageComment(@PathVariable("num") Integer index, Model model){

        PageInfo pageInfo=new PageInfo(commentService.getAllCommentNoReply(index),3);
        model.addAttribute("commentPageInfo",pageInfo);
        model.addAttribute("partPath","admin/manageComment");

        return "admin/manageComment.jsp";
    }
    @RequestMapping("/deleteComment")
    public String deleteComment(Integer coid,Integer num,Integer aid){
        commentService.deleteCommentByCoid(coid);
        Article article=articleService.getArticleByAid(aid);
        article.setCommentCount(article.getCommentCount()-1);
        articleService.updateByPrimaryKeySelective(article);
        return "redirect:/admin/manageComment/"+num;
    }
}
