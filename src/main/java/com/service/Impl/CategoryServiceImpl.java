package com.service.Impl;

import com.dao.CategoryMapper;
import com.github.pagehelper.PageHelper;
import com.pojo.Category;
import com.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author: wuhui
 * @time: 2019/3/20 22:33
 * @desc:
 */
@Service
public class CategoryServiceImpl implements CategoryService {
    @Autowired
    CategoryMapper mapper;


    @Override
    public Category getCategoryByCid(Integer cid) {

        return mapper.selectByPrimaryKey(cid);
}

    @Override
    public List<Category> getCategoryAsParent() {
        return mapper.selectCategoryAsParent();
    }

    @Override
    public void updateByCid(Category category) {
        mapper.updateByPrimaryKeySelective(category);
    }

    @Override
    public void addCategory(Category category) {
        mapper.insert(category);
    }

    @Override
    public void deleteCategoryByCid(Integer cid) {
        mapper.deleteByPrimaryKey(cid);
    }

    @Override
    public List<Category> getAllCategory(Integer index) {
        PageHelper.startPage(index, 6);
        return mapper.selectByExample(null);
    }

    /**
   * @desc: 获取all分类对象
   */
    @Override
    public List<Category> getAllCategoryWithSon() {
        if (mapper.selectAllCategoryWithSon() != null) {
            return mapper.selectAllCategoryWithSon();
        }
        return null;
    }
}
