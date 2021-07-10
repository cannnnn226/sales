package com.whut.service;

import com.whut.entity.Goods;

import java.util.List;

public interface GoodsService {

    List<Goods> findAll(Integer page, Integer size, String name, Integer goodsType);

    Goods getGoodsById(Integer id);

    void updateGoods(Goods goods);

    void addGoods(Goods goods);

    Goods getGoodsByName(String name);
}
