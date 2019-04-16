package com.service.Impl;

import com.dao.ArticleMapper;
import com.dao.CommentMapper;
import com.dao.ReplyMapper;
import com.github.pagehelper.PageHelper;
import com.pojo.Comment;
import com.pojo.CommentExample;
import com.pojo.ReplyExample;
import com.service.CommentService;
import com.service.ReplyService;
import com.sun.org.apache.regexp.internal.RE;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author: wuhui
 * @time: 2019/4/5 14:46
 * @desc:
 */
@Service
public class CommentServiceImpl implements CommentService {
    @Autowired
    CommentMapper mapper;
    @Autowired
    ReplyMapper replyMapper;
    @Autowired
    ArticleMapper articleMapper;

    @Override
    public List<Integer> getCommentByAidSimple(Integer aid) {
        return  mapper.selectCommentByAidSimple(aid);
    }

    @Override
    public void insertComment(Comment comment) {
        mapper.insert(comment);
    }

    @Override
    public List<Comment> getAllCommentNoReply(Integer index) {
        PageHelper.startPage(index, 6);
        return mapper.selectAllCommentNoReply();
    }

    @Override
    public List<Comment> getCommentByAidWithReply(Integer aid) {
       return mapper.selectByAidWithReply(aid);
    }

   /* @Override
    public Comment selectByCoid(Integer coid) {
        return mapper.selectByPrimaryKey(coid);
    }*/


    @Override
    public void deleteCommentByAid(Integer aid) {
        CommentExample example=new CommentExample();
        CommentExample.Criteria criteria=example.createCriteria();
        criteria.andAidEqualTo(aid);
        mapper.deleteByExample(example);
    }

    @Override
    public void deleteCommentByCoid(Integer coid) {
        mapper.deleteByPrimaryKey(coid);
        ReplyExample example=new ReplyExample();
        ReplyExample.Criteria criteria=example.createCriteria();
        criteria.andPcoidEqualTo(coid);
        replyMapper.deleteByExample(example);
    }
}
