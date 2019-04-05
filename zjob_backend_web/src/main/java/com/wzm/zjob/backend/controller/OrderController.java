package com.wzm.zjob.backend.controller;

import com.github.pagehelper.PageInfo;
import com.wzm.zjob.Constants.Constant;
import com.wzm.zjob.entity.Order;
import com.wzm.zjob.excel.ExcelUtil;
import com.wzm.zjob.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
@RequestMapping("/backend/order")
public class OrderController {
    @Autowired
    private OrderService orderService;
    @RequestMapping("/findAllByPage")
    //分页查询记录
    public String findAllByPage(Integer pageNum, Model model) {
        if (ObjectUtils.isEmpty(pageNum)) {
            pageNum = Constant.PAGE_NUM;
        }
        //调用service获取新闻列表
        PageInfo<Order> pageInfo = orderService.findAllByPage(pageNum, Constant.PAGE_SIZE);
        //将该列表存入model,相当于request
        model.addAttribute("data", pageInfo);
        //返回产品新闻管理视图
        return "orderManager";
    }

    @RequestMapping("/download")
    @ResponseBody
    public void download(HttpServletResponse resp){
        try {
            resp.setContentType("application/x-excel");
            //设置处理方式为附件处理方式
            resp.setHeader("content-disposition", "attachment;filename=order.xls");
            List<Order> orderList = orderService.findAll();
            ExcelUtil.exportExcel(orderList, resp.getOutputStream());
            System.out.println("导出成功");
        }catch (Exception e){
            System.out.println("导出失败");
        }

    }


}
