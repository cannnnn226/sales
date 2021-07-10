package com.whut.controller;

import com.github.pagehelper.PageInfo;
import com.whut.entity.Bill;
import com.whut.entity.Details;
import com.whut.entity.Goods;
import com.whut.entity.User;
import com.whut.service.BillService;
import com.whut.service.DetailsService;
import com.whut.service.GoodsService;
import com.whut.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/bill")
public class BillController {

    private final BillService billService;

    private final UserService userService;

    private final DetailsService detailsService;

    private final GoodsService goodsService;

    public BillController(BillService billService, UserService userService, DetailsService detailsService, GoodsService goodsService) {
        this.billService = billService;
        this.userService = userService;
        this.detailsService = detailsService;
        this.goodsService = goodsService;
    }

    @RequestMapping("/findAll")
    public ModelAndView findAll(@RequestParam(defaultValue = "1") Integer page,
                                @RequestParam(defaultValue = "8") Integer size,
                                @RequestParam(defaultValue = "0") int type,
                                String code,
                                Integer searchId,
                                HttpSession session) {

        if (type == 1) {//1代表模糊查询
            session.setAttribute("searchCode", code);
            session.setAttribute("searchId", searchId);
        } else if (type == 0) {
            code = (String) session.getAttribute("searchCode");
            searchId = (Integer) session.getAttribute("searchId");
            if (searchId == null) {
                searchId = 0;
            }
        } else {//全查，name置空
            session.removeAttribute("searchCode");
            session.removeAttribute("searchId");
            searchId = 0;
        }

        List<Bill> billList = billService.findAll(page, size, code, searchId);
        List<User> userList = userService.getAllUsers();
        PageInfo<Bill> pageInfo = new PageInfo<>(billList);

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/jsp/billList");
        modelAndView.addObject("billList", pageInfo);
        modelAndView.addObject("userList", userList);

        return modelAndView;
    }

    //显示账单详情，根据账单id（bill_id）查details表中所有对应bill_id的goods_id，再由goods_id查goods的详细信息
    @RequestMapping("/findOne")
    public ModelAndView findOne(Integer id) {
        ModelAndView modelAndView = new ModelAndView();

        List<Details> detailsList = detailsService.findDetailsByBillId(id);
        List<Goods> goodsList = new ArrayList<>();
        for (Details details : detailsList) {
            Goods goods = goodsService.getGoodsById(details.getGoods_id());
            goods.setQuantity(details.getQuantity());
            goods.setPurchasePrice(details.getQuantity() * goods.getPrice());//单样商品的总价
            goodsList.add(goods);
        }

        Bill bill = billService.getBillById(id);
        User user = userService.getUserById(bill.getUser_id());
        modelAndView.addObject("user", user);
        modelAndView.addObject("bill", bill);
        modelAndView.addObject("goodsList", goodsList);
        modelAndView.setViewName("/jsp/billView");
        return modelAndView;
    }

    //删除
    @RequestMapping("/delBill")
    @Transactional
    public String delBillById(Integer id) {
        List<Details> detailsList = detailsService.findDetailsByBillId(id);
        for (Details details : detailsList) {
            detailsService.delDetailsById(details.getId());
        }
        billService.delBillById(id);
        return "redirect:/bill/findAll.do";
    }
}
