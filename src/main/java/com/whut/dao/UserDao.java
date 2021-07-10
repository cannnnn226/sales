package com.whut.dao;

import com.whut.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserDao {

    User getUserById(Integer id);

    List<User> findAll(@Param("name") String name,
                       @Param("identity") Integer identity);

    void updateUser(User user);

    void addUser(User user);

    void delUserById(Integer id);

    List<User> getAllUsers();
}
