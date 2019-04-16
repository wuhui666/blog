package com.controller;

import com.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

/**
 * @author: wuhui
 * @time: 2019/3/19 11:52
 * @desc:
 */
@Controller
public class CategoryController {
    @Autowired
    CategoryService service;
}
