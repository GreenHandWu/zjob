package com.wzm.zjob.front.controller;

import com.wzm.zjob.Constants.ResponseResult;
import com.wzm.zjob.entity.Company;
import com.wzm.zjob.entity.User;
import com.wzm.zjob.exception.SysuserNotExistException;
import com.wzm.zjob.service.CompanyService;
import com.wzm.zjob.service.UserService;
import com.wzm.zjob.utils.HttpClientUtils;
import com.wzm.zjob.utils.QQMailUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

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

    @RequestMapping("/sms/sendUserVerificationCode")
    @ResponseBody
    public ResponseResult sendUserVerificationCode(String forgetUserName, HttpSession session){
        User user = userService.findByUserName(forgetUserName);
        if(user==null||user.equals(null)){
            return  ResponseResult.fail("该用户不存在");
        }
        try {
            //随机生成6位数字
            int randCode=(int)((Math.random()*9+1)*100000);
            session.setAttribute("randCode",randCode);
            session.setAttribute("user",user);
            QQMailUtil.QQmail("验证码",user.getEmail(), String.valueOf(randCode));
            return  ResponseResult.success("验证码发送成功");
        } catch (Exception e) {
            //e.printStackTrace();
            return  ResponseResult.fail("验证码发送失败");
        }
    }
    @RequestMapping("/sms/sendCompanyVerificationCode")
    @ResponseBody
    public ResponseResult sendCompanyVerificationCode(String forgetCompanyName, HttpSession session){
        Company company = companyService.findByCompanyName(forgetCompanyName);
        if(company==null||company.equals(null)){
            return  ResponseResult.fail("该用户不存在");
        }
        try {
            //随机生成6位数字
            int randCode=(int)((Math.random()*9+1)*100000);
            session.setAttribute("randCode",randCode);
            session.setAttribute("company",company);

            QQMailUtil.QQmail("验证码",company.getCompanyEmail(), String.valueOf(randCode));
            return  ResponseResult.success("验证码发送成功");
        } catch (Exception e) {
            //e.printStackTrace();
            return  ResponseResult.fail("验证码发送失败");
        }
    }

    @RequestMapping("/sms/modifyUserPsw")
    public String modifyUserPsw(User user,int verificationCode, HttpSession session,Model model){
        User usercheck= (User)session.getAttribute("user");
        int randCode= (int) session.getAttribute("randCode");
        if(usercheck.getUserName().equals(user.getUserName())&&randCode==verificationCode){
            usercheck.setPassword(DigestUtils.md5DigestAsHex(user.getPassword().getBytes()));
            userService.modifyUserPassWordBySms(usercheck);
            model.addAttribute("successMsg","密码修改成功");
        }else{
            model.addAttribute("errorMsg","验证码错误");
        }
        return "login";
    }
    @RequestMapping("/sms/modifyCompanyPsw")
    public String modifyCompanyPsw(Company company,int verificationCode, HttpSession session,Model model){
        Company companycheck= (Company) session.getAttribute("company");
        int randCode= (int) session.getAttribute("randCode");

        if(companycheck.getCompanyName().equals(company.getCompanyName())&&randCode==verificationCode){
            companycheck.setPassword(DigestUtils.md5DigestAsHex(company.getPassword().getBytes()));
            companyService.modifyCompanyPassWordBySms(company);
            model.addAttribute("successMsg","密码修改成功");
        }else{
            model.addAttribute("errorMsg","验证码错误");
        }


        return "login";
    }

}
