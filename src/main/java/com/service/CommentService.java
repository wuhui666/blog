package com.service;

import com.pojo.Comment;

import java.util.List;

/**
 * @author: wuhui
 * @time: 2019/4/5 14:45
 * @desc:
 */
public interface CommentService {
    List<Comment> getCommentByAidWithReply(Integer aid);
    void insertComment(Comment comment);
    void deleteCommentByCoid(Integer coid);
    void deleteCommentByAid(Integer aid);
    List<Integer> getCommentByAidSimple(Integer aid);
   /* void deleteCommentByUid(Integer uid);*/
    List<Comment> getAllCommentNoReply(Integer index);

}
