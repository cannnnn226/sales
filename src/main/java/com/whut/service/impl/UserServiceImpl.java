package com.whut.service.impl;

import com.github.pagehelper.PageHelper;
import com.whut.dao.UserDao;
import com.whut.entity.User;
import com.whut.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    private final UserDao userDao;

    public UserServiceImpl(UserDao userDao) {
        this.userDao = userDao;
    }

    @Override
    public User getUserById(Integer id) {
        return userDao.getUserById(id);
    }

    @Override
    public List<User> findAll(Integer page, Integer size, String name, Integer identity) {
        PageHelper.startPage(page, size);
        return userDao.findAll(name, identity);
    }

    @Override
    public List<User> getAllUsers() {
        return userDao.getAllUsers();
    }

    @Override
    public void updateUser(User user) {
        userDao.updateUser(user);
    }

    @Override
    public void addUser(User user) {
        userDao.addUser(user);
    }

    @Override
    public void delUserById(Integer id) {
        userDao.delUserById(id);
    }
}
