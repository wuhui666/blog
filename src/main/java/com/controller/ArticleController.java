package com.controller;

import com.github.pagehelper.PageInfo;
import com.pojo.Article;
import com.pojo.Comment;
import com.service.ArticleService;
import com.service.CategoryService;
import com.service.CommentService;
import com.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.List;

/**
 * @author: wuhui
 * @time: 2019/3/25 11:06
 * @desc:
 */
@Controller
@SessionAttributes(value = {"articlePageInfo"})
public class ArticleController {
    @Autowired
    ArticleService articleService;
    @Autowired
    CategoryService categoryService;
    @Autowired
    UserService userService;
    @Autowired
    CommentService commentService;


    @RequestMapping("/category-articles/{cid}/{startIndex}")
    public String listArticlesByCategory(
            @PathVariable("cid") Integer cid,HttpSession session,
            @PathVariable(value = "startIndex") Integer startIndex,
            Model model){
        List<Article> articleList=articleService.getArticlesByCategory(cid,startIndex);
        if (articleList!=null){
            PageInfo pageInfo=new PageInfo(articleList,3);
            model.addAttribute("articlePageInfo",pageInfo);
            //供页码超链接拼接
            model.addAttribute("partPath", "category-articles/"+cid);
            model.addAttribute("currentCategory",categoryService.getCategoryByCid(cid));
        }
        /*hotlist*/
        model.addAttribute("hotList", articleService.getHotArticleList());
        /*random*/
        List<Article> simpleArticleList= (List<Article>) session.getAttribute("simpleArticleList");
        System.out.println(simpleArticleList.isEmpty());
        Article[] random=new Article[5];

        for (int count = 0; count <random.length ;) {
            int k= (int) (Math.random()*simpleArticleList.size());
            Article temp=simpleArticleList.get(k);
            int flag=0;//防重
            if (count==0){
                random[count]=temp;
                ++count;

            }
            else {
                for (Article aRandom : random) {

                    if (temp.equals(aRandom)) {
                        flag = 1;
                        break;
                    }
                }
                if (flag==0){
                    random[count]=temp;
                    ++count;
                }
            }
        }
        model.addAttribute("randomList", Arrays.asList(random));
        return "home.jsp";
    }
    @RequestMapping("/article/{aid}")
    public String getArticleByAid(@PathVariable Integer aid, Model model, HttpSession session){

        Article currentArticle = articleService.getArticleByAid(aid);

        currentArticle.setViewCount(currentArticle.getViewCount() + 1);

        articleService.updateByPrimaryKeySelective(currentArticle);
        List<Comment> commentList = commentService.getCommentByAidWithReply(aid);
        model.addAttribute("userOfArticle", userService.getUserByUid(currentArticle.getUid()));
        model.addAttribute("commentList", commentList);

        session.setAttribute("currentArticle", currentArticle);
        /*pre-next*/
        model.addAttribute("preArticle",articleService.getPreArticleByAid(aid));

        model.addAttribute("nextArticle",articleService.getNextArticleByAid(aid));


        return "detail.jsp";
    }

}
