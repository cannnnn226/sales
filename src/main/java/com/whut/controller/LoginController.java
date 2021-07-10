package com.whut.controller;

import com.alibaba.fastjson.JSONObject;
import com.whut.entity.User;
import com.whut.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/login")
public class LoginController {

    private final UserService userService;

    public LoginController(UserService userService) {
        this.userService = userService;
    }

    /**
     * 用户登录
     */
    @RequestMapping("/doLogin")
    @ResponseBody
    public String login(Integer id, String password, HttpSession session) {
        User user = userService.getUserById(id);
        JSONObject jsonObject = new JSONObject();
        if (null == user) {//账号错误
            jsonObject.put("result", "2");
        } else {
            if (user.getPassword().equals(password)) {//登录成功
                session.setAttribute("user", user);
                jsonObject.put("result", "1");
            } else {//密码错误
                jsonObject.put("result", "3");
            }
        }
        return jsonObject.toString();
    }

    /**
     * 退出系统
     */
    @RequestMapping("/logOut")
    public String loginOut(HttpSession session) {
        session.removeAttribute("user");
        return "/login";
    }

}
