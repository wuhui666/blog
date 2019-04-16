package com.service.Impl;

import com.dao.ReplyMapper;
import com.github.pagehelper.PageHelper;
import com.pojo.Reply;
import com.pojo.ReplyExample;
import com.service.ReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author: wuhui
 * @time: 2019/4/6 18:44
 * @desc:
 */
@Service
public class ReplyServiceImpl implements ReplyService {
    @Autowired
    ReplyMapper mapper;
    @Override
    public Integer addReply(Reply reply) {

        return mapper.insertSelective(reply);
    }

    @Override
    public void deleteByPcoidInIdList(List<Integer> list) {
        ReplyExample example=new ReplyExample();
        ReplyExample.Criteria criteria=example.createCriteria();
        criteria.andPcoidIn(list);
        mapper.deleteByExample(example);
    }

    @Override
    public void deleteReplyByPcoid(Integer pcoid) {
        ReplyExample example=new ReplyExample();
        ReplyExample.Criteria criteria=example.createCriteria();
        criteria.andPcoidEqualTo(pcoid);
        mapper.deleteByExample(example);
    }

    @Override
    public void deleteByRid(Integer rid) {
        mapper.deleteByPrimaryKey(rid);
    }

    @Override
    public List<Reply> getAllReply(Integer index) {
        PageHelper.startPage(index, 6);

        return mapper.selectAllForAdmin();
    }

    @Override
    public void deleteReply(Integer rid) {
        mapper.deleteByPrimaryKey(rid);
    }
}
