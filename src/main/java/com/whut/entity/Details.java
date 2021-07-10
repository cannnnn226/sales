package com.whut.entity;

/**
 * 账单详情实体类
 * */
public class Details {

    /** 账单详情表主键id */
    private Integer id;

    /** 商品数量 */
    private Integer quantity;

    /** 外键：账单id */
    private Integer bill_id;

    /** 外键：商品id */
    private Integer goods_id;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Integer getBill_id() {
        return bill_id;
    }

    public void setBill_id(Integer bill_id) {
        this.bill_id = bill_id;
    }

    public Integer getGoods_id() {
        return goods_id;
    }

    public void setGoods_id(Integer goods_id) {
        this.goods_id = goods_id;
    }

    public Details() {
    }

    public Details(Integer id, Integer quantity, Integer bill_id, Integer goods_id) {
        this.id = id;
        this.quantity = quantity;
        this.bill_id = bill_id;
        this.goods_id = goods_id;
    }
}
