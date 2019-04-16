package com.service.Impl;

import com.dao.ArticleMapper;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.pojo.Article;
import com.pojo.ArticleExample;
import com.service.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * @author: wuhui
 * @time: 2019/3/25 11:07
 * @desc:
 */
@Service
public class ArticleServiceImpl implements ArticleService {
    @Autowired
    ArticleMapper mapper;
    
    @Override
    public List<Article> getALLArticleOrderByDate(Integer startIndex) {

        ArticleExample example=new ArticleExample();
        example.setOrderByClause("create_time desc");
        PageHelper.startPage(startIndex,5);
        return  mapper.selectByExampleWithBLOBs(example);
    }

    @Override
    public void setArticleDefaultByCid(Integer cid) {
        mapper.setCidDefault(cid);/*set to default category*/
    }

    @Override
    public Article getArticleByAid(Integer aid) {
        return mapper.selectByPrimaryKey(aid);
    }

    @Override
    public List<Article> getArticlesByCategory(Integer cid,Integer startIndex) {
        PageHelper.startPage(startIndex,5);
        return mapper.selectByCategory(cid);
    }

    @Override
    public int addArticle(Article article) {
        return  mapper.insertSelective(article);
    }

    @Override
    public void deleteArticleByAid(Integer aid) {
        mapper.deleteByPrimaryKey(aid);
    }

    @Override
    public Article getPreArticleByAid(Integer aid) {
        return mapper.selectPreArticleByAid(aid);
    }

    @Override
    public Article getNextArticleByAid(Integer aid) {
        return mapper.selectNextArticleByAid(aid);
    }

    @Override
    public void updateByPrimaryKeySelective(Article article) {
       mapper.updateByPrimaryKeySelective(article);

    }

    @Override
    public List<Article> getHotArticleList() {
        return mapper.selectHotList();
    }

    @Override
    public List<Article> getAllArticleSimply() {
        return mapper.selectAllSimply();
    }
}



