package com.whut.entity;

import java.util.Date;

/**
 * 账单实体类
 * */
public class Bill {

    /** 账单主键id */
    private Integer id;

    /** 账单创建时间 */
    private Date createTime;

    /** 账单总价 */
    private Double totalPrice;

    /** 账单编码 */
    private String code;

    /** 外键：售货员id */
    private Integer user_id;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Integer getUser_id() {
        return user_id;
    }

    public void setUser_id(Integer user_id) {
        this.user_id = user_id;
    }

    public Bill() {
    }

    public Bill(Integer id, Date createTime, Double totalPrice, String code, Integer user_id) {
        this.id = id;
        this.createTime = createTime;
        this.totalPrice = totalPrice;
        this.code = code;
        this.user_id = user_id;
    }
}
