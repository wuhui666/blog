package com.controller.admin;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageInfo;
import com.pojo.Category;
import com.service.ArticleService;
import com.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.concurrent.locks.ReentrantLock;

/**
 * @author: wuhui
 * @time: 2019/4/15 13:29
 * @desc:
 */
@Controller
@RequestMapping("/admin")
public class AdminCategoryController {
    @Autowired
    CategoryService categoryService;

    @Autowired
    ArticleService articleService;

    @RequestMapping("/manageCategory/{num}")
    public String manageCategory(@PathVariable("num") Integer index, Model model){

        PageInfo pageInfo=new PageInfo(categoryService.getAllCategory(index),3);

        model.addAttribute("categoryPageInfo",pageInfo);
        model.addAttribute("partPath","admin/manageCategory");
        model.addAttribute("parentCategoryList",categoryService.getCategoryAsParent());
        return  "admin/manageCategory.jsp";
    }

    @RequestMapping("/deleteCategory")
    public String deleteCategory(Integer cid,Integer num,HttpSession session){
        categoryService.deleteCategoryByCid(cid);
        articleService.setArticleDefaultByCid(cid);
        session.setAttribute("categoryList", categoryService.getAllCategoryWithSon());
        return "redirect:/admin//manageCategory/"+num;
    }

    @RequestMapping(value = "/addCategory",produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String addCategory(String cname, Integer pcid, HttpSession session){
        Category category=new Category();
        category.setCname(cname);
        category.setPcid(pcid);
        category.setcIcon(null);
        categoryService.addCategory(category);
        session.setAttribute("categoryList", categoryService.getAllCategoryWithSon());
        return JSON.toJSONString("添加成功");
    }

    @RequestMapping(value = "/editCategory",produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String editCategory(Integer cid,String cname,Integer pcid,HttpSession session){
        Category category=categoryService.getCategoryByCid(cid);
        category.setCname(cname);
        category.setPcid(pcid);
        System.out.println(cid);
        System.out.println(cname);
        System.out.println(pcid);
        categoryService.updateByCid(category);
        session.setAttribute("categoryList", categoryService.getAllCategoryWithSon());
        return  JSON.toJSONString("修改成功");

    }
}
