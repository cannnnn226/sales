package com.whut.service.impl;

import com.github.pagehelper.PageHelper;
import com.whut.dao.GoodsDao;
import com.whut.entity.Goods;
import com.whut.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GoodsServiceImpl implements GoodsService {

    private final GoodsDao goodsDao;

    public GoodsServiceImpl(GoodsDao goodsDao) {
        this.goodsDao = goodsDao;
    }

    @Override
    public List<Goods> findAll(Integer page, Integer size, String name, Integer goodsType) {
        PageHelper.startPage(page, size);
        return goodsDao.findAll(name, goodsType);
    }

    @Override
    public Goods getGoodsById(Integer id) {
        return goodsDao.getGoodsById(id);
    }

    @Override
    public void updateGoods(Goods goods) {
        goodsDao.updateGoods(goods);
    }

    @Override
    public void addGoods(Goods goods) {
        goodsDao.addGoods(goods);
    }

    @Override
    public Goods getGoodsByName(String name) {
        return goodsDao.getGoodsByName(name);
    }
}
