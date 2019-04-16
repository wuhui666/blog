package com.service.Impl;

import com.dao.UserMapper;
import com.github.pagehelper.PageHelper;
import com.pojo.User;
import com.pojo.UserExample;
import com.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author: wuhui
 * @time: 2019/3/28 16:16
 * @desc:
 */
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    UserMapper mapper;
    @Override
    public User getUserByEmailAndPassword(String email,String password) {
        UserExample example=new UserExample();
        UserExample.Criteria criterion=example.createCriteria();
        criterion.andEmailEqualTo(email).andPasswordEqualTo(password);
        List<User> list=mapper.selectByExample(example);
        if (list!=null&&list.size()!=0){
            return list.get(0);
        }
        return null;
    }

    @Override
    public User getUserByUid(Integer uid) {

        return mapper.selectByPrimaryKey(uid);
    }

    @Override
    public void updateUserSective(User user) {
        mapper.updateByPrimaryKeySelective(user);
    }

    @Override
    public List<User> getAllUser(Integer index) {
        PageHelper.startPage(index, 5);
        UserExample example=new UserExample();
        UserExample.Criteria criteria=example.createCriteria();
        criteria.andIsadminEqualTo(false);//not admin
        return mapper.selectByExample(example);
    }

    @Override
    public void deleteUserByUid(Integer uid) {
        mapper.deleteByPrimaryKey(uid);
    }

    @Override
    public User getAdmin() {
        UserExample example=new UserExample();
        UserExample.Criteria criteria=example.createCriteria();
        criteria.andIsadminEqualTo(true);
        List<User> list=mapper.selectByExample(example);
        if (list != null) {
            return list.get(0);
        }
        return null;

    }

    @Override
    public Integer insert(User user) {
        Integer newId=mapper.insertSelective(user);
        return newId;
    }
}
