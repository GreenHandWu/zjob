package com.wzm.zjob.front.controller;

import com.wzm.zjob.entity.Company;
import com.wzm.zjob.entity.User;
import com.wzm.zjob.exception.SysuserNotExistException;
import com.wzm.zjob.service.CompanyService;
import com.wzm.zjob.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
public class LoginAndRegisteController {
    @Autowired
    private CompanyService companyService;
    @Autowired
    private UserService userService;

    @RequestMapping("/login")
    public String login(String loginName, String password, String state, Model model, HttpSession session){
        if("user".equals(state)){
            try {
                User user= userService.findByLoginNameAndPassowrd(loginName, password);
                session.setAttribute("user",user);
                return "forward:/front/user/findJobByParams";
            }catch (SysuserNotExistException e){
                model.addAttribute("error",e.getMessage());
                return "login";
            }
        }else if("company".equals(state)){
            try {
                Company company= companyService.findByLoginNameAndPassowrd(loginName, password);
                session.setAttribute("company",company);
                return "company/main";
            }catch (SysuserNotExistException e){
                model.addAttribute("error",e.getMessage());
                return "login";
            }
        }
        else {
            return "login";
        }
    }


    @RequestMapping("/loginOut")
    @ResponseBody
    public void login(Model model, HttpSession session) {
        session.invalidate();
    }


}
