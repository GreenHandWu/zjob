package com.wzm.zjob.backend.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wzm.zjob.Constants.Constant;
import com.wzm.zjob.Constants.ResponseResult;
import com.wzm.zjob.entity.Sysuser;
import com.wzm.zjob.exception.SysuserNotExistException;
import com.wzm.zjob.service.DateService;
import com.wzm.zjob.service.SysuserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.DigestUtils;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/backend/sysuser")
public class SysuserController {
    @Autowired
    private SysuserService sysuserService;
    @Autowired
    private DateService dateService;
    @RequestMapping("/login")
    public String login(String loginName,String password,Model model,HttpSession session){
        try {
            Sysuser sysuser= sysuserService.findByLoginNameAndPassowrd(loginName, password);
            //将该sysuser存入session作用域
            session.setAttribute("sysuser",sysuser);
            //返回视图名称,通过视图解析器，将该名称拼接成完整的页面路径，从而实现页面的返回
            return "main";
        } catch (SysuserNotExistException e) {
            //e.printStackTrace();
            model.addAttribute("errorMsg",e.getMessage());
            return "login";
        }
    }

    @RequestMapping("/loginOut")
    @ResponseBody
    public void login(Model model,HttpSession session){
        session.invalidate();
    }

    @RequestMapping("/findAllByPage")
    //分页查询记录
    public String findAllByPage(Integer pageNum, Model model) {
        if(ObjectUtils.isEmpty(pageNum)){
            pageNum= Constant.PAGE_NUM;
        }
        PageHelper.startPage(pageNum,Constant.PAGE_SIZE);
        List<Sysuser> sysusers = sysuserService.findAll();
        PageInfo<Sysuser> pageInfo = new PageInfo<>(sysusers);
        model.addAttribute("data",pageInfo);

        return "sysuserManager";
    }

    @RequestMapping("/checkLoginName")
    @ResponseBody
    //自动将被校验的值注入
    public Map<String, Object> checkLoginName(String loginName, Integer id) {
        Map<String, Object> map = new HashMap<>();
        boolean res = sysuserService.checkLoginName(loginName,id);
        //如果不存在该标题，可用
        if (res) {
            map.put("valid", true);
        } else {
            map.put("valid", false);
            map.put("message", "用户【" + loginName + "】已经存在");
        }
        return map;

    }
    @RequestMapping("/findById")
    @ResponseBody
    public ResponseResult findById(int id) {
        Sysuser sysuser = sysuserService.findById(id);
        return  ResponseResult.success(sysuser);
    }
    @RequestMapping("/add")
    @ResponseBody
    public ResponseResult add(Sysuser sysuser) {
        sysuser.setPassword(DigestUtils.md5DigestAsHex(sysuser.getPassword().getBytes()));
        sysuser.setCreateDate(dateService.getTime());
        sysuser.setIsValid(Constant.VALID);
        if (sysuserService.add(sysuser) == 1) {
            return ResponseResult.success("添加成功");
        } else {
            return ResponseResult.fail("添加失败");
        }

    }


    @RequestMapping("/modifyStatus")
    @ResponseBody
    public ResponseResult modifyStatus(int id) {
        if(sysuserService.modifyStatus(id)==1){
            return  ResponseResult.success("更新用户状态成功");}
        else {
            return  ResponseResult.fail("更新用户状态失败");
        }
    }
    @RequestMapping("/modify")
    @ResponseBody
    public ResponseResult modify(Sysuser sysuser) {
        sysuser.setPassword(DigestUtils.md5DigestAsHex(sysuser.getPassword().getBytes()));
        sysuserService.modify(sysuser);
        return ResponseResult.success("修改成功");
    }

}
