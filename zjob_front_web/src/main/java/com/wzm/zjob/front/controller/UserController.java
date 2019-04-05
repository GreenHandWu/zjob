package com.wzm.zjob.front.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wzm.zjob.Constants.Constant;
import com.wzm.zjob.Constants.ResponseResult;
import com.wzm.zjob.front.vo.UserVo;
import com.wzm.zjob.dto.UserDto;
import com.wzm.zjob.entity.*;
import com.wzm.zjob.params.JobParam;
import com.wzm.zjob.service.*;
import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/front/user")
public class UserController {
    @Autowired
    private UserService userService;
    @Autowired
    private PositionService positionService;
    @Autowired
    private FindJobService findJobService;
    @Autowired
    private CompanyService companyService;
    @Autowired
    private NewsService newsService;
    @Autowired
    private DateService dateService;

    @RequestMapping("/checkName")
    @ResponseBody
    public Map<String, Object> checkName(String userName) {
        Map<String, Object> map = new HashMap<>();
        boolean res = userService.checkUserName(userName, null);
        //如果名字不存在，可用
        if (res) {
            map.put("valid", true);
        } else {
            //当valid值为true,不输出消息，为false,输出message所对应的值
            map.put("valid", false);
            map.put("message", "用户(" + userName + ")已经存在");
        }
        return map;

    }

    @RequestMapping("/registe")
    public String registe(User user, Model model) {
        int res = userService.add(user);
        if (res == 1) {
            model.addAttribute("error", "注册成功");
        } else {
            model.addAttribute("error", "注册失败");
        }
        return "login";
    }



    @RequestMapping("/findJobByParams")
    public String findJobByParams(JobParam jobParam, Integer pageNum, Model model) {
        jobParam.setIsValid(Constant.VALID);
        if (ObjectUtils.isEmpty(pageNum)) {
            pageNum = Constant.PAGE_NUM;
        }
        PageHelper.startPage(pageNum, Constant.PAGE_SIZE);
        List<Position> positionList = positionService.findByParams(jobParam);
        PageInfo<Position> pageInfo = new PageInfo<>(positionList);
        model.addAttribute("data", pageInfo);
        model.addAttribute("jobParam", jobParam);
        return "user/findJob";
    }


    @RequestMapping("/apply")
    @ResponseBody
    public ResponseResult apply(int id, HttpSession session) {
        try {
            User user = (User) session.getAttribute("user");
            Date time = dateService.getTime();


            findJobService.add(id, user.getId(), Constant.INVALID,time);
            return ResponseResult.success("申请成功");
        } catch (Exception e) {
            return ResponseResult.fail("已经申请过了");
        }
    }

    @RequestMapping("/findCompanyById")
    @ResponseBody
    public ResponseResult findCompanyById(int id) {
        Company company = companyService.findById(id);
        return ResponseResult.success(company);
    }


    @RequestMapping("/findPositionById")
    @ResponseBody
    public ResponseResult findPositionById(int id) {
        Position position = positionService.findById(id);
        return ResponseResult.success(position);
    }

    @RequestMapping("/findNews")
    //分页查询记录
    public String findAllByPage(Integer pageNum, Model model) {
        if (ObjectUtils.isEmpty(pageNum)) {
            pageNum = Constant.PAGE_NUM;
        }
        //调用service获取新闻列表
        PageInfo<News> pageInfo = newsService.findAllByPageAndEnable(pageNum, Constant.PAGE_SIZE, Constant.VALID);
        //将该列表存入model,相当于request
        model.addAttribute("data", pageInfo);
        //返回产品新闻管理视图
        return "user/news";
    }

    @RequestMapping("/findNewsById")
    @ResponseBody
    public ResponseResult findNewsById(int id) {
        News News = newsService.findById(id);
        return ResponseResult.success(News);
    }

    @RequestMapping("/findMyData")
    //分页查询记录
    public String findMyData() {
        //返回产品新闻管理视图
        return "user/mydata";
    }

    @RequestMapping("/download")
    public void download(String fileName, String userName,
                         HttpServletResponse response) throws IOException {
        String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
        URL url = new URL(fileName);
        URLConnection urlConnection = url.openConnection();
        InputStream is = urlConnection.getInputStream();

        response.addHeader("Content-Disposition", "attachment;filename=" + userName + "." + suffix);
        response.setContentType("multipart/form-data");
        BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
        //创建缓冲字节流
        //将输入流写入输出流
        byte[] data = new byte[4096];
        int size = 0;
        size = is.read(data);
        while (size != -1) {
            bos.write(data, 0, size);
            size = is.read(data);
        }
        //关闭这些流
        is.close();
        bos.flush();
        bos.close();
    }


    @RequestMapping("/checkUserName")
    @ResponseBody
    //自动将被校验的值注入
    public Map<String, Object> checkUserName(String userName, Integer id) {

        Map<String, Object> map = new HashMap<>();
        boolean res = userService.checkUserName(userName, id);
        //如果不存在该标题，可用
        if (res) {
            map.put("valid", true);
        } else {
            map.put("valid", false);
            map.put("message", "用户【" + userName + "】已经存在");
        }
        return map;

    }

    @RequestMapping("/modify")
    public String modify(UserVo userVo, HttpSession session, Model model) {
        UserDto userDto = new UserDto();
        try {
            //将vo中属性值对应的拷贝到dto的相关属性中(属性必须一一对应),获取部分值
            PropertyUtils.copyProperties(userDto, userVo);
            //获取原始文件名
            userDto.setFileName(userVo.getFile().getOriginalFilename());
            userDto.setInputStream(userVo.getFile().getInputStream());
            //productDto.setUploadPath(uploadPath);
            userService.modify(userDto);
            model.addAttribute("successMsg", "修改成功");
            User user = userService.findById(userVo.getId());
            session.setAttribute("user", user);
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
        }
        //返回列表页面
        return "user/mydata";
    }

    @RequestMapping("modifyPwd")
    @ResponseBody
    public String modifyPwd(Integer id, String oldPass, String newPass) {
        try {
                userService.modifyPwd(id, oldPass, newPass);
            System.out.println(1234679);
            return "success";
        } catch (Exception e) {

                return "fail";
        }


    }


    @RequestMapping("/findMyapply")
    public String  findMyapply(Integer pageNum, Model model,HttpSession session) {
        User user = (User) session.getAttribute("user");
        Integer id = user.getId();
        if (ObjectUtils.isEmpty(pageNum)) {
            pageNum = Constant.PAGE_NUM;
        }
        PageHelper.startPage(pageNum, Constant.PAGE_SIZE);
        List<FindJob> findJobList = findJobService.findByUserId(id);
        PageInfo<FindJob> pageInfo = new PageInfo<>(findJobList);
        model.addAttribute("data", pageInfo);
        return "user/myapply";
    }

}
