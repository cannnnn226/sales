package com.whut.dao;

import com.whut.entity.Goods;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface GoodsDao {

    List<Goods> findAll(@Param("name") String name,
                        @Param("type") Integer goodsType);

    Goods getGoodsById(Integer id);

    void updateGoods(Goods goods);

    void addGoods(Goods goods);

    Goods getGoodsByName(String name);
}
