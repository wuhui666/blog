package com.interceptor;

import com.pojo.Article;
import com.pojo.Category;
import com.service.ArticleService;
import com.service.CategoryService;
import com.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.context.request.WebRequestInterceptor;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @author: wuhui
 * @time: 2019/3/28 11:26
 * @desc:
 */

public class PreResourcesInterceptor implements WebRequestInterceptor {
    @Autowired
    CategoryService categoryService;
    @Autowired
    ArticleService articleService;
    @Autowired
    UserService userService;

    @Override
    public void preHandle(WebRequest webRequest) throws Exception {
        List<Article> simpleList= (List<Article>) webRequest.getAttribute("simpleArticleList", WebRequest.SCOPE_SESSION);
        List<Category> simpleCategoryList= (List<Category>) webRequest.getAttribute("simpleArticleList", WebRequest.SCOPE_SESSION);
        Integer admin_uid= (Integer) webRequest.getAttribute("adminUid", WebRequest.SCOPE_SESSION);
         if (simpleCategoryList==null||simpleCategoryList.isEmpty()){

            webRequest.setAttribute("categoryList", categoryService.getAllCategoryWithSon(), WebRequest.SCOPE_SESSION);
        }

        if (simpleList==null||simpleList.isEmpty()){

            webRequest.setAttribute("simpleArticleList",articleService.getAllArticleSimply(),WebRequest.SCOPE_SESSION);
        }

        if (admin_uid==null){
            webRequest.setAttribute("adminUid",userService.getAdmin().getUid(),WebRequest.SCOPE_SESSION);
        }


    }

    @Override
    public void postHandle(WebRequest webRequest, ModelMap modelMap) throws Exception {

    }

    @Override
    public void afterCompletion(WebRequest webRequest, Exception e) throws Exception {


    }
}
