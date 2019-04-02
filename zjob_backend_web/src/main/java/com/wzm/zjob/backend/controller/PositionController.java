package com.wzm.zjob.backend.controller;

import com.github.pagehelper.PageInfo;
import com.wzm.zjob.Constants.Constant;
import com.wzm.zjob.Constants.ResponseResult;
import com.wzm.zjob.entity.Company;
import com.wzm.zjob.entity.Position;
import com.wzm.zjob.service.CompanyService;
import com.wzm.zjob.service.PositionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/backend/position")
public class PositionController {
    @Autowired
    private PositionService positionService;
    @Autowired
    private CompanyService companyService;

    @ModelAttribute("companyList")
    //执行该controller下所有请求,先执行该方法，值存入key为companyList中,默认作用相当于request
    public List<Company> loadCompanys(){
        List<Company> companyList= companyService.findEnable(Constant.VALID);
        return  companyList;
    }
    @RequestMapping("/findAllByPage")
    //分页查询记录
    public String findAllByPage(Integer pageNum, Model model) {

        if (ObjectUtils.isEmpty(pageNum)) {
            pageNum = Constant.PAGE_NUM;
        }
        //调用service获取新闻列表
        PageInfo<Position> pageInfo = positionService.findAllByPage(pageNum, Constant.PAGE_SIZE);
        //将该列表存入model,相当于request
        model.addAttribute("data", pageInfo);
        //返回产品新闻管理视图
        return "positionManager";
    }

    @RequestMapping("/add")
    @ResponseBody
    public ResponseResult add(Position position,int companyId, HttpSession session) {
        position.setCompany(new Company(companyId));
        System.out.println(companyId);
        position.setStatus(Constant.VALID);
        if (positionService.add(position) == 1) {
            return ResponseResult.success("添加成功");
        } else {
            return ResponseResult.fail("添加失败");
        }
    }

    @RequestMapping("/findById")
    @ResponseBody
    public ResponseResult findById(int id) {
        Position position = positionService.findById(id);
        return  ResponseResult.success(position);
    }

    @RequestMapping("/modify")
    @ResponseBody
    public ResponseResult modify(Position position,int companyId) {
        position.setCompany(new Company(companyId));
        positionService.modify(position);
        return ResponseResult.success("修改成功");
    }



    @RequestMapping("/deleteById")
    @ResponseBody
    public ResponseResult deleteById(int id) {
        if(positionService.deleteById(id)==1){
            return  ResponseResult.success("删除成功");}
        else {
            return  ResponseResult.fail("删除失败");
        }
    }

    @RequestMapping("/modifyStatus")
    @ResponseBody
    public ResponseResult modifyStatus(int id) {
        if(positionService.modifyStatus(id)==1){
            return  ResponseResult.success("更新职位状态成功");}
        else {
            return  ResponseResult.fail("更新职位状态失败");
        }
    }


}
