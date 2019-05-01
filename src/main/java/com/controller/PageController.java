package com.controller;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageInfo;
import com.pojo.Article;
import com.service.ArticleService;
import com.service.CategoryService;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @author: wuhui
 * @time: 2019/3/17 16:32
 * @desc:
 */
@Controller
public class PageController {
    @Autowired
    CategoryService categoryService;
    @Autowired
    ArticleService articleService;

    @RequestMapping("/")
    public String root(Model model,HttpSession session){
        PageInfo pageInfo=new PageInfo(articleService.getALLArticleOrderByDate(1),3);
        model.addAttribute("articlePageInfo",pageInfo);
        /*article abstract*/
        List<String> abstractList=new ArrayList<>(pageInfo.getList().size());
        Document document;
        String realText;
        for (Article a:(List<Article>)pageInfo.getList()){
            document=Jsoup.parse(a.getContent());
            realText=document.body().text();
            if (realText.length()>140){
                realText=realText.substring(0,140);
            }
            abstractList.add(realText);
        }
        model.addAttribute("abstractList", abstractList);
        model.addAttribute("partPath","home");//页码的超链接拼接使用
        /*hotlist*/
        model.addAttribute("hotList", articleService.getHotArticleList());
        /*random*/
        List<Article> simpleArticleList= (List<Article>) session.getAttribute("simpleArticleList");
        Article[] random=new Article[6];
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
    @RequestMapping("/home/{num}")
    public String toHomePage(HttpSession session,@PathVariable(value = "cid",required = false) Integer cid, @PathVariable(value = "num") Integer startIndex, Model model){

            PageInfo pageInfo=new PageInfo(articleService.getALLArticleOrderByDate(startIndex),3);
            model.addAttribute("articlePageInfo",pageInfo);
            /*article abstract*/
            List<String> abstractList=new ArrayList<>(pageInfo.getList().size());
            Document document;
            String realText;
            for (Article a:(List<Article>)pageInfo.getList()){
                document=Jsoup.parse(a.getContent());
                realText=document.body().text();
                if (realText.length()>140){
                    realText=realText.substring(0,140);
                }
                abstractList.add(realText);
            }
            model.addAttribute("abstractList", abstractList);
            model.addAttribute("partPath","home");//页码的超链接拼接使用
            /*hotlist*/
            model.addAttribute("hotList", articleService.getHotArticleList());
            /*random*/
            List<Article> simpleArticleList= (List<Article>) session.getAttribute("simpleArticleList");
            Article[] random=new Article[6];

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


    @RequestMapping("/register")
    public String toRegisterPage(){
        return "register.jsp";
    }
    @RequestMapping("/login")
    public String toLogin(){

        return "login.jsp";
    }

   /* @RequestMapping("/keep_url")
    @ResponseBody
    public String keep_url(@RequestBody String url, HttpSession session){
        JSONObject jsonObject= JSON.parseObject(url);
        session.setAttribute("to_url", jsonObject.getString("to_url"));
        System.out.println(session.getAttribute("to_url"));
        return JSON.toJSONString("6p");
    }*/
    @RequestMapping("/keep_url")
    @ResponseBody
    public String keep_url(@RequestParam("to_url") String url, HttpSession session){

        session.setAttribute("to_url", url);

        return JSON.toJSONString("6p");
    }


}
