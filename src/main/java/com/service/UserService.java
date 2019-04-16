package com.service;

import com.dao.UserMapper;
import com.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author: wuhui
 * @time: 2019/3/28 16:13
 * @desc:
 */

public interface UserService {

    User getUserByEmailAndPassword(String email,String password);
    User getUserByUid(Integer uid);
    Integer insert(User user);
    User getAdmin();
    void updateUserSective(User user);
    List<User> getAllUser(Integer index);
    void  deleteUserByUid(Integer uid);

}
