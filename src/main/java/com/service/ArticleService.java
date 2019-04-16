package com.service;

import com.pojo.Article;

import java.util.List;

/**
 * @author: wuhui
 * @time: 2019/3/25 11:07
 * @desc:
 */
public interface ArticleService {
    List<Article> getALLArticleOrderByDate(Integer startIndex);
    List<Article> getArticlesByCategory(Integer cid,Integer startIndex);
    Article getArticleByAid(Integer aid);
    int addArticle(Article article);
    void updateByPrimaryKeySelective(Article article);
    Article getPreArticleByAid(Integer aid);
    Article getNextArticleByAid(Integer aid);
    List<Article> getHotArticleList();
    List<Article> getAllArticleSimply();
    void deleteArticleByAid(Integer aid);
    void setArticleDefaultByCid(Integer cid);//for category delete
}
