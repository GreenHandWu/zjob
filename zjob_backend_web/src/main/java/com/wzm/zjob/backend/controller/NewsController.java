package com.wzm.zjob.backend.controller;

import com.github.pagehelper.PageInfo;
import com.wzm.zjob.Constants.Constant;
import com.wzm.zjob.Constants.ResponseResult;
import com.wzm.zjob.entity.News;
import com.wzm.zjob.entity.Sysuser;
import com.wzm.zjob.service.DateService;
import com.wzm.zjob.service.NewsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/backend/news")
public class NewsController {
    @Autowired
    private NewsService newsService;
    @Autowired
    private DateService dateService;
    @RequestMapping("/findAllByPage")
    //分页查询记录
    public String findAllByPage(Integer pageNum, Model model) {

        if (ObjectUtils.isEmpty(pageNum)) {
            pageNum = Constant.PAGE_NUM;
        }
        //调用service获取新闻列表
        PageInfo<News> pageInfo = newsService.findAllByPage(pageNum, Constant.PAGE_SIZE);
        //将该列表存入model,相当于request
        model.addAttribute("data", pageInfo);
        //返回产品新闻管理视图
        return "newsManager";
    }

    //校验标题是否已经存在
    @RequestMapping("checkTitle")
    @ResponseBody
    //自动将被校验的值注入
    public Map<String, Object> checkTitle(String newsTitle,Integer id) {
        Map<String, Object> map = new HashMap<>();
        boolean res = newsService.checkTitle(newsTitle,id);
        //如果不存在该标题，可用
        if (res) {
            map.put("valid", true);
        } else {
            map.put("valid", false);
            map.put("message", "标题【" + newsTitle + "】已经存在");
        }
        return map;

    }


    //添加新闻
    @RequestMapping("/add")
    public String add(News news, Integer pageNum, HttpSession session, Model model) {
        System.out.println(pageNum);
        Sysuser sysuser = (Sysuser) session.getAttribute("sysuser");
        news.setCreateDate(dateService.getTime());
        news.setSysuser(sysuser);
        news.setNewsStatus(Constant.VALID);
        System.out.println(news.toString());
        if (newsService.add(news) == 1) {
            model.addAttribute("successMsg","添加成功");
        } else {
            model.addAttribute("errorMsg", "添加失败");
        }
        return "forward:findAllByPage?pageNum="+pageNum;//转发到findAll请求

    }
    @RequestMapping("/deleteById")
    @ResponseBody
    public ResponseResult deleteById(int id) {
        if(newsService.deleteById(id)==1){
        return  ResponseResult.success("删除成功");}
        else {
            return  ResponseResult.fail("删除失败");
        }
    }

    @RequestMapping("/modifyStatus")
    @ResponseBody
    public ResponseResult modifyStatus(int id) {
        if(newsService.modifyStatus(id)==1){
            return  ResponseResult.success("更新新闻状态成功");}
        else {
            return  ResponseResult.fail("更新新闻状态失败");
        }
    }


    @RequestMapping("/findById")
    @ResponseBody
    public ResponseResult findById(int id) {
        News News = newsService.findById(id);
        return  ResponseResult.success(News);
    }

    @RequestMapping("/modify")
    @ResponseBody
    public ResponseResult modify(News news) {
        newsService.modify(news);

        return ResponseResult.success("修改成功");
    }
}
