package com.controller.admin;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageInfo;
import com.pojo.Article;
import com.pojo.Comment;
import com.pojo.Result;
import com.service.ArticleService;
import com.service.CategoryService;
import com.service.CommentService;
import com.service.ReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

/**
 * @author: wuhui
 * @time: 2019/3/30 10:26
 * @desc:
 */
@Controller
public class AdminArticleController {
    @Autowired
    ArticleService articleService;
    @Autowired
    CategoryService categoryService;
    @Autowired
    CommentService commentService;
    @Autowired
    ReplyService replyService;

    @RequestMapping("/admin/addBlogPage")
    public String addBlogPage(@RequestParam(required = false) Integer aid,Model model){
        if (aid!=null){//edit
            model.addAttribute("editArticle", articleService.getArticleByAid(aid));
        }
        return "admin/addBlogPage.jsp";//return directly if add

    }
    @RequestMapping("/admin/editor")
    public String editorPage(@RequestParam(required = false) Integer aid, Model model){
        if (aid!=null){//edit
            model.addAttribute("editArticle", articleService.getArticleByAid(aid));
        }
        return "admin/editor.jsp";//return directly if add
    }
    @RequestMapping("/admin/manageBlog/{num}")
    public String manageBlog(@PathVariable("num") Integer startIndex, Model model){

        //不需要，已经准备好
        /*model.addAttribute("categoryList",categoryService.getAllCategoryWithSon());*/

        PageInfo pageInfo=new PageInfo(articleService.getALLArticleOrderByDate(startIndex),3);
        model.addAttribute("articlePageInfo",pageInfo);
        model.addAttribute("partPath","admin/manageBlog");
        return "admin/manageBlog.jsp";

    }

    /*add or edit a blog*/
    @RequestMapping(value = "/admin/addBlog",produces = "application/json;charset=utf-8")
    @ResponseBody//不将返回值视为逻辑视图名，将返回值直接写入response的body
    public String addBlog(@RequestBody String jsonObject){
        JSONObject object=JSON.parseObject(jsonObject);
        if (object.getInteger("aid")==null) {/*the article to be edited is null,so it means add*/
            Article article = new Article();
            article.setCid(object.getInteger("cid"));
            article.setTitle(object.getString("title"));
            article.setContent(object.getString("content"));
            article.setViewCount(0);
            article.setCommentCount(0);
            article.setCreateTime(new Date());
            article.setUid(object.getInteger("uid"));
            articleService.addArticle(article);
            return JSON.toJSONString(Result.success("添加成功！"));
        }
        else {/*edit*/
            Article article = articleService.getArticleByAid(object.getInteger("aid"));
            article.setCid(object.getInteger("cid"));
            article.setTitle(object.getString("title"));
            article.setContent(object.getString("content"));
            articleService.updateByPrimaryKeySelective(article);
            return JSON.toJSONString(Result.success("修改成功！"));
        }

    }

    @RequestMapping("/admin/deleteBlog")
    public String deleteBlog(Integer aid,Integer num){
        List<Integer> commentIdList=commentService.getCommentByAidSimple(aid);
        commentService.deleteCommentByAid(aid);//delete comments

        if (commentIdList != null&&commentIdList.size()!=0) {
            replyService.deleteByPcoidInIdList(commentIdList);//delete replies
        }
        articleService.deleteArticleByAid(aid);//delete articles
        return "redirect:/admin/manageBlog/"+num;
    }

}
