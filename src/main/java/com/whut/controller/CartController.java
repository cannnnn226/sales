package com.whut.controller;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageInfo;
import com.whut.entity.Bill;
import com.whut.entity.Details;
import com.whut.entity.Goods;
import com.whut.entity.User;
import com.whut.service.BillService;
import com.whut.service.DetailsService;
import com.whut.service.GoodsService;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.RandomUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
@RequestMapping("/cart")
public class CartController {

    private final GoodsService goodsService;

    private final BillService billService;

    private final DetailsService detailsService;

    public CartController(GoodsService goodsService, BillService billService, DetailsService detailsService) {
        this.goodsService = goodsService;
        this.billService = billService;
        this.detailsService = detailsService;
    }

    @RequestMapping("/findAll")
    public ModelAndView findAll(@RequestParam(defaultValue = "1") Integer page,
                                @RequestParam(defaultValue = "5") Integer size,
                                @RequestParam(defaultValue = "0") int type,
                                String name,
                                Integer goodsType,
                                HttpSession session) {
        List<Goods> cartList = (List<Goods>) session.getAttribute("cartList");

        if (type == 1) {//1代表模糊查询
            session.setAttribute("searchGoodsName", name);
            session.setAttribute("goodsType", goodsType);
        } else if (type == 0) {
            name = (String) session.getAttribute("searchGoodsName");
            goodsType = (Integer) session.getAttribute("goodsType");
            if (goodsType == null) {
                goodsType = 0;
            }
        } else {//全查，name置空
            session.removeAttribute("searchGoodsName");
            session.removeAttribute("goodsType");
            goodsType = 0;
        }

        List<Goods> goodsList = goodsService.findAll(page, size, name, goodsType);
        ModelAndView modelAndView = new ModelAndView();
        PageInfo<Goods> pageInfo = new PageInfo<>(goodsList);
        modelAndView.addObject("goodsList", pageInfo);
        if (null == cartList) {//购物车为空
            modelAndView.setViewName("/jsp/cart");
        } else {
            double countPrice = 0;//总金额
            int countQuantity = 0;//总数量
            for (Goods goods : cartList) {
                countPrice += goods.getQuantity() * goods.getPrice();
                countQuantity += goods.getQuantity();
            }
            modelAndView.addObject("info", "总共有" + cartList.size() + "种类型，共" + countQuantity + "件商品，总价" + countPrice + "元");
            modelAndView.addObject("countPrice", countPrice);
            modelAndView.addObject("cartList", cartList);
            modelAndView.setViewName("/jsp/cart");
        }
        return modelAndView;
    }

    //添加到购物车中
    @RequestMapping("/addGoods")
    @ResponseBody
    public String addGoods(Integer id, HttpSession session) {
        List<Goods> cartList = (List<Goods>) session.getAttribute("cartList");
        if (null == cartList) {
            cartList = new ArrayList<>();
        }

        JSONObject jsonObject = new JSONObject();

        Goods goods1 = goodsService.getGoodsById(id);
        if (goods1.getQuantity() == 0) {//商品库存为0
            jsonObject.put("result", 3);
            return jsonObject.toString();
        }

        for (Goods goods : cartList) {//购物车中已经存在此商品
            if (goods.getId() == id || goods1.getQuantity() == 0) {
                jsonObject.put("result", 2);//操作失败标识
                return jsonObject.toString();
            }
        }
        //获取商品信息

        goods1.setQuantity(1);
        //添加到购物车中
        cartList.add(goods1);
        session.removeAttribute("cartList");
        session.setAttribute("cartList", cartList);

        jsonObject.put("result", 1);//操作成功标识
        return jsonObject.toString();
    }

    //商品数量-1
    @RequestMapping("/subGoods")
    @ResponseBody
    public String subGoods(Integer id, HttpSession session) {
        List<Goods> cartList = (List<Goods>) session.getAttribute("cartList");
        JSONObject jsonObject = new JSONObject();
        for (Goods goods : cartList) {
            if (goods.getId() == id) {
                if (goods.getQuantity() - 1 <= 0) {//商品数量-1之后为0
                    jsonObject.put("result", 2);//操作失败标识
                    return jsonObject.toString();
                } else {//可以减一，执行
                    goods.setQuantity(goods.getQuantity() - 1);
                }

            }
        }
        session.removeAttribute("cartList");
        session.setAttribute("cartList", cartList);

        jsonObject.put("result", 1);//操作成功标识
        return jsonObject.toString();
    }

    //商品数量+1
    @RequestMapping("/plusGoods")
    @ResponseBody
    public String plusGoods(Integer id, HttpSession session) {
        List<Goods> cartList = (List<Goods>) session.getAttribute("cartList");
        JSONObject jsonObject = new JSONObject();
        Goods goods1 = goodsService.getGoodsById(id);
        for (Goods goods : cartList) {
            if (goods.getId() == id) {
                if (goods.getQuantity() + 1 > goods1.getQuantity()) {//商品数量+1之后大于库存
                    jsonObject.put("result", 2);//操作失败标识
                    return jsonObject.toString();
                } else {//可以加一，执行
                    goods.setQuantity(goods.getQuantity() + 1);
                }

            }
        }
        session.removeAttribute("cartList");
        session.setAttribute("cartList", cartList);

        jsonObject.put("result", 1);//操作成功标识
        return jsonObject.toString();
    }

    //移除商品
    @RequestMapping("/delGoods")
    @ResponseBody
    public String delGoods(Integer id, HttpSession session) {
        List<Goods> cartList = (List<Goods>) session.getAttribute("cartList");
        JSONObject jsonObject = new JSONObject();
        Iterator<Goods> iterator = cartList.listIterator();
        while (iterator.hasNext()) {
            Goods goods = iterator.next();
            if (goods.getId() == id) {
                iterator.remove();
                break;
            }
        }
        session.removeAttribute("cartList");
        session.setAttribute("cartList", cartList);

        jsonObject.put("result", 1);//操作成功标识
        return jsonObject.toString();
    }

    //结算，根据购物车中商品信息生成bill表信息和details表信息，并移除session中的cartList
    @RequestMapping("/pay")
    @Transactional
    @ResponseBody
    public String pay(HttpSession session) {
        List<Goods> cartList = (List<Goods>) session.getAttribute("cartList");
        JSONObject jsonObject = new JSONObject();
        if (null == cartList) {//购物车为空
            jsonObject.put("result", 2);//操作失败标识
            return jsonObject.toString();
        }

        double countPrice = 0;
        for (Goods goods : cartList) {
            countPrice += goods.getPrice() * goods.getQuantity();
        }
        //添加bill
        User user = (User) session.getAttribute("user");
        Bill bill = new Bill();
        Date nowDate = new Date();
        bill.setTotalPrice(countPrice);
        bill.setUser_id(user.getId());
        bill.setCreateTime(nowDate);
        bill.setCode(DateFormatUtils.format(nowDate, "yyyyMMddHHmm") + RandomStringUtils.randomNumeric(5) + String.format("%03d", user.getId()));
        billService.addBill(bill);

        //添加details，修改goods表的商品数量
        for (Goods goods : cartList) {
            Details details = new Details();
            details.setBill_id(bill.getId());
            details.setGoods_id(goods.getId());
            details.setQuantity(goods.getQuantity());
            detailsService.addDetails(details);

            Goods goods1 = goodsService.getGoodsById(goods.getId());
            goods.setQuantity(goods1.getQuantity() - goods.getQuantity());
            goodsService.updateGoods(goods);
        }

        session.removeAttribute("cartList");
        jsonObject.put("result", 1);//操作成功标识
        return jsonObject.toString();
    }

}
