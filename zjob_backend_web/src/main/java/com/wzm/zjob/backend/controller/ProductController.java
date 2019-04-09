package com.wzm.zjob.backend.controller;

import com.github.pagehelper.PageInfo;
import com.wzm.zjob.Constants.Constant;
import com.wzm.zjob.Constants.ResponseResult;
import com.wzm.zjob.entity.Product;
import com.wzm.zjob.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/backend/product")
public class ProductController {
    @Autowired
    private ProductService productService;
    @RequestMapping("/findAllByPage")
    public String findAllByPage(Integer pageNum, Model model) {

        if (ObjectUtils.isEmpty(pageNum)) {
            pageNum = Constant.PAGE_NUM;
        }
        //调用service获取新闻列表
        PageInfo<Product> pageInfo = productService.findAllByPage(pageNum, Constant.PAGE_SIZE);
        //将该列表存入model,相当于request
        model.addAttribute("data", pageInfo);
        //返回产品新闻管理视图
        return "productManager";
    }
    @RequestMapping("checkProductName")
    @ResponseBody
    //自动将被校验的值注入
    public Map<String, Object> checkProductName(String productName, Integer id) {
        Map<String, Object> map = new HashMap<>();
        boolean res = productService.checkProductName(productName,id);
        //如果不存在该标题，可用
        if (res) {
            map.put("valid", true);
        } else {
            map.put("valid", false);
            map.put("message", "产品名称【" + productName + "】已经存在");
        }
        return map;
    }

    @RequestMapping("/add")
    @ResponseBody
    public ResponseResult add(Product product) {
        if (productService.add(product) == 1) {
            return ResponseResult.success("添加成功");
        } else {
            return ResponseResult.fail("添加失败");
        }

    }

    @RequestMapping("/findById")
    @ResponseBody
    public ResponseResult findById(int id) {
        Product product = productService.findById(id);
        return  ResponseResult.success(product);
    }

    @RequestMapping("/modify")
    @ResponseBody
    public ResponseResult modify(Product product) {
        productService.modify(product);

        return ResponseResult.success("修改成功");
    }

    @RequestMapping("/deleteById")
    @ResponseBody
    public ResponseResult deleteById(int id) {
        try{
            productService.deleteById(id);
            return  ResponseResult.success("删除成功");
        }catch (Exception e){
            return  ResponseResult.fail("删除失败");
        }
    }

}
