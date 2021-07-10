package com.whut.entity;

import java.util.Date;

/**
 * 商品实体类
 * */
public class Goods {

    /** 商品主键id */
    private Integer id;

    /** 商品名称 */
    private String name;

    /** 商品进价 */
    private Double purchasePrice;

    /** 商品售价 */
    private Double price;

    /** 商品描述 */
    private String desc;

    /** 商品数量 */
    private Integer quantity;

    /** 商品类型（1：食品，2：日用品，3：家用电器） */
    private Integer type;

    @Override
    public String toString() {
        return "Goods{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", purchasePrice=" + purchasePrice +
                ", price=" + price +
                ", desc='" + desc + '\'' +
                ", quantity=" + quantity +
                ", type=" + type +
                '}';
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

    public Double getPurchasePrice() {
        return purchasePrice;
    }

    public void setPurchasePrice(Double purchasePrice) {
        this.purchasePrice = purchasePrice;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Goods() {
    }

    public Goods(Integer id, String name, Double purchasePrice, Double price, String desc, Integer quantity, Integer type) {
        this.id = id;
        this.name = name;
        this.purchasePrice = purchasePrice;
        this.price = price;
        this.desc = desc;
        this.quantity = quantity;
        this.type = type;
    }
}
