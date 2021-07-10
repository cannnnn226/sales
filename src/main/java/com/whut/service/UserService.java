package com.whut.service;

import com.whut.entity.User;

import java.util.List;

public interface UserService {

    User getUserById(Integer id);

    List<User> findAll(Integer page, Integer size, String name, Integer identity);

    List<User> getAllUsers();

    void updateUser(User user);

    void addUser(User user);

    void delUserById(Integer id);
}
