package com.whut.controller;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageInfo;
import com.whut.entity.Goods;
import com.whut.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/goods")
public class GoodsController {

    private final GoodsService goodsService;

    public GoodsController(GoodsService goodsService) {
        this.goodsService = goodsService;
    }

    @RequestMapping("/findAll")
    public ModelAndView findAll(@RequestParam(defaultValue = "1") Integer page,
                                @RequestParam(defaultValue = "8") Integer size,
                                @RequestParam(defaultValue = "0") int type,
                                String name,
                                Integer goodsType,
                                HttpSession session) {

        if (type == 1) {//1代表模糊查询
            session.setAttribute("searchGoodsName", name);
            session.setAttribute("goodsType", goodsType);
        } else if (type == 0) {//分页的模糊查询
            name = (String) session.getAttribute("searchGoodsName");
            goodsType = (Integer) session.getAttribute("goodsType");
            if (goodsType == null) {
                goodsType = 0;
            }
        } else {//全查，name置空，type置0
            session.removeAttribute("searchGoodsName");
            session.removeAttribute("goodsType");
            name = "";
            goodsType = 0;
        }

        List<Goods> goodsList = goodsService.findAll(page, size, name, goodsType);
        PageInfo<Goods> pageInfo = new PageInfo<>(goodsList);

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/jsp/goodsList");
        modelAndView.addObject("goodsList", pageInfo);

        return modelAndView;
    }

    @RequestMapping("/selOne")
    public ModelAndView selOne(Integer id) {
        ModelAndView modelAndView = new ModelAndView();
        Goods goods = goodsService.getGoodsById(id);
        modelAndView.addObject("goods", goods);
        modelAndView.setViewName("/jsp/goodsUpdate");
        return modelAndView;
    }

    @RequestMapping("/updateGoods")
    @ResponseBody
    public String updateGoods(Goods goods) {
        JSONObject jsonObject = new JSONObject();
        Goods goods1 = goodsService.getGoodsByName(goods.getName());
        if (goods1.getId() == goods.getId()) {
            goodsService.updateGoods(goods);
            jsonObject.put("result", "1");
            return jsonObject.toString();
        }

        jsonObject.put("result", "2");

        return jsonObject.toString();
    }

    @RequestMapping("/addGoods")
    @ResponseBody
    public String addGoods(Goods goods) {
        JSONObject jsonObject = new JSONObject();

        Goods goods1 = goodsService.getGoodsByName(goods.getName());
        if (null == goods1) {//不存在同名商品
            goodsService.addGoods(goods);
            jsonObject.put("result", "1");
            jsonObject.put("id", goods.getId());
            return jsonObject.toString();
        }
        jsonObject.put("result", "2");
        jsonObject.put("name1", goods.getName());
        return jsonObject.toString();
    }


}
