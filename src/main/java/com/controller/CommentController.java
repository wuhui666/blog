package com.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.pojo.Article;
import com.pojo.Comment;
import com.service.ArticleService;
import com.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Date;

/**
 * @author: wuhui
 * @time: 2019/4/5 17:51
 * @desc:
 */
@Controller
public class CommentController {
    @Autowired
    CommentService commentService;
    @Autowired
    ArticleService articleService;

    @RequestMapping(value = "/comment/add")
    @ResponseBody
    public String addCommment(Comment comment){

        comment.setCreateTime(new Date());
        commentService.insertComment(comment);
        Article article=articleService.getArticleByAid(comment.getAid());
        article.setCommentCount(article.getCommentCount()+1);
        articleService.updateByPrimaryKeySelective(article);
        JSONObject jsonObject=new JSONObject();
        jsonObject.put("msg", "成功");
        return jsonObject.toJSONString();
    }
    @RequestMapping("/comment/delete/{coid}")
    @ResponseBody
    public String deleteComment(@PathVariable Integer coid, HttpSession session){
        Article article= (Article) session.getAttribute("currentArticle");

        if (article != null) {

            article.setCommentCount(article.getCommentCount()-1);
            articleService.updateByPrimaryKeySelective(article);
            commentService.deleteCommentByCoid(coid);//both comment and replies are deleted

        }
        return JSON.toJSONString("额...成功");
    }
}
