package com.whut.entity;

import java.util.Date;

/**
 * 用户实体类
 * */
public class User {

    /** 用户主键id */
    private Integer id;

    /** 用户姓名 */
    private String name;

    /** 用户密码 */
    private String password;

    /** 性别（1：男，2：女） */
    private Integer gender;

    /** 用户出生日期 */
    private Date birthday;

    /** 用户电话号码 */
    private String phone;

    /** 用户住址 */
    private String address;

    /** 身份（1：管理员，2：售货员） */
    private Integer identity;


    public User() {
    }

    public User(Integer id, String name, String password, Integer gender, Date birthday, String phone, String address, Integer identity) {
        this.id = id;
        this.name = name;
        this.password = password;
        this.gender = gender;
        this.birthday = birthday;
        this.phone = phone;
        this.address = address;
        this.identity = identity;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Integer getGender() {
        return gender;
    }

    public void setGender(Integer gender) {
        this.gender = gender;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Integer getIdentity() {
        return identity;
    }

    public void setIdentity(Integer identity) {
        this.identity = identity;
    }



}
