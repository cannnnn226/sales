package com.whut.controller;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageInfo;
import com.whut.entity.User;
import com.whut.service.BillService;
import com.whut.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {

    private final UserService userService;

    private final BillService billService;

    public UserController(UserService userService, BillService billService) {
        this.userService = userService;
        this.billService = billService;
    }

    /**
     * 注册一个类型解析器
     *
     * @param binder
     */
    @InitBinder
    public void InitBinder(WebDataBinder binder) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(true);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

    @RequestMapping("/findAll")
    public ModelAndView findAll(@RequestParam(defaultValue = "1") Integer page,
                                @RequestParam(defaultValue = "5") Integer size,
                                @RequestParam(defaultValue = "0") int type,
                                String name,
                                Integer userType,
                                HttpSession session) {

        if (type == 1) {//1代表模糊查询
            session.setAttribute("searchName", name);
            session.setAttribute("userType", userType);
        } else if (type == 0) {
            name = (String) session.getAttribute("searchName");
            userType = (Integer) session.getAttribute("userType");
        } else {//全查，name置空
            session.removeAttribute("searchName");
            session.removeAttribute("userType");
        }

        List<User> userList = userService.findAll(page, size, name, userType);
        PageInfo<User> pageInfo = new PageInfo<>(userList);

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/jsp/userList");
        modelAndView.addObject("userList", pageInfo);

        return modelAndView;
    }

    @RequestMapping("/findOne")
    public ModelAndView findOne(Integer id) {
        ModelAndView modelAndView = new ModelAndView();
        User user = userService.getUserById(id);
        modelAndView.addObject("user", user);
        modelAndView.setViewName("/jsp/userView");
        return modelAndView;
    }

    //修改前查询
    @RequestMapping("/selOne")
    public ModelAndView selOne(Integer id) {
        ModelAndView modelAndView = new ModelAndView();
        User user = userService.getUserById(id);
        modelAndView.addObject("user", user);
        modelAndView.setViewName("/jsp/userUpdate");
        return modelAndView;
    }

    //修改
    @RequestMapping("/updUserById")
    @ResponseBody
    public String updUserById(User user, HttpSession session) {

        JSONObject jsonObject = new JSONObject();
        userService.updateUser(user);
        User user1 = (User) session.getAttribute("user");
        if (user.getId() == user1.getId()) {//修改的是当前登录用户
            jsonObject.put("result", "2");
        } else {
            jsonObject.put("result", "1");
        }

        return jsonObject.toString();
    }

    //添加
    @RequestMapping("/addUser")
    @ResponseBody
    public String addUser(User user) {

        userService.addUser(user);

        JSONObject object = new JSONObject();
        object.put("result", "1");
        object.put("id", user.getId());
        return object.toString();

    }

    //删除
    @RequestMapping("/delUser")
    @Transactional
    public String delUserById(Integer id) {
        billService.updateBillsByUserId(id);
        userService.delUserById(id);
        return "redirect:/user/findAll.do";
    }
}
