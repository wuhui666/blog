package com.service;

import com.pojo.Reply;

import java.util.List;

/**
 * @author: wuhui
 * @time: 2019/4/6 18:44
 * @desc:
 */
public interface ReplyService {
    Integer addReply(Reply reply);
    void deleteReply(Integer rid);
    void deleteReplyByPcoid(Integer pcoid);
    void deleteByPcoidInIdList(List<Integer> list);
    /*void deleteReplyByUid(Integer uid);*/
    List<Reply> getAllReply(Integer index);
    void deleteByRid(Integer rid);
}
