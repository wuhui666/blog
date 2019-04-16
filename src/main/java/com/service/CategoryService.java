package com.service;

import com.pojo.Category;

import java.util.List;

/**
 * @author: wuhui
 * @time: 2019/3/20 22:31
 * @desc:
 */
public interface CategoryService {
     List<Category> getAllCategoryWithSon();
     Category getCategoryByCid(Integer cid);
     List<Category> getAllCategory(Integer index);
     void deleteCategoryByCid(Integer cid);
    List<Category> getCategoryAsParent();
    void addCategory(Category category);
    void updateByCid(Category category);


}
