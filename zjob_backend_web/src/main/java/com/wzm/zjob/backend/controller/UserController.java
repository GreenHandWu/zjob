package com.wzm.zjob.backend.controller;

import com.github.pagehelper.PageInfo;
import com.wzm.zjob.Constants.Constant;
import com.wzm.zjob.Constants.ResponseResult;
import com.wzm.zjob.backend.vo.UserVo;
import com.wzm.zjob.dto.UserDto;
import com.wzm.zjob.entity.User;
import com.wzm.zjob.service.UserService;
import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.DigestUtils;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.HashMap;
import java.util.Map;
@Controller
@RequestMapping("/backend/user")
public class UserController {
    @Autowired
    private UserService userService;
    @RequestMapping("/findAllByPage")
    //分页查询记录
    public String findAllByPage(Integer pageNum, Model model) {

        if (ObjectUtils.isEmpty(pageNum)) {
            pageNum = Constant.PAGE_NUM;
        }
        //调用service获取产品类型列表
        PageInfo<User> pageInfo = userService.findAllByPage(pageNum, Constant.PAGE_SIZE);
        //将该列表存入model,相当于request
        model.addAttribute("data", pageInfo);
        //返回产品类型管理视图
        return "userManager";
    }

    @RequestMapping("/checkUserName")
    @ResponseBody
    //自动将被校验的值注入
    public Map<String, Object> checkUserName(String userName,Integer id) {

        Map<String, Object> map = new HashMap<>();
        boolean res = userService.checkUserName(userName,id);
        //如果不存在该标题，可用
        if (res) {
            map.put("valid", true);
        } else {
            map.put("valid", false);
            map.put("message", "用户【" + userName + "】已经存在");
        }
        return map;

    }

    //添加用户
    @RequestMapping("/add")
    public String add(UserVo userVo,Integer pageNum, HttpSession session,Model model) {
        UserDto userDto = new UserDto();
        try {
            //将vo中属性值对应的拷贝到dto的相关属性中(属性必须一一对应),获取部分值
            PropertyUtils.copyProperties(userDto, userVo);
            //获取原始文件名
            userDto.setFileName(userVo.getFile().getOriginalFilename());
            userDto.setInputStream(userVo.getFile().getInputStream());
            //productDto.setUploadPath(uploadPath);
            userService.add(userDto);
            model.addAttribute("successMsg","添加成功");
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
        }
        //返回列表页面
        return "forward:findAllByPage?pageNum="+pageNum;//转发到findAll请求

    }





    @RequestMapping("/findById")
    @ResponseBody
    public ResponseResult findById(int id) {
        User user = userService.findById(id);
        return  ResponseResult.success(user);
    }

    @RequestMapping("/download")
    public void download(String fileName, String userName,
                         HttpServletResponse response) throws IOException {
        String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
        URL url = new URL(fileName);
        URLConnection urlConnection = url.openConnection();
        InputStream is = urlConnection.getInputStream();

        response.addHeader("Content-Disposition", "attachment;filename=" + userName+"."+suffix);
        response.setContentType("multipart/form-data");
        BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
        //创建缓冲字节流
        //将输入流写入输出流
        byte[] data = new byte[4096];
        int size=0;
        size = is.read(data);
        while (size!=-1){
            bos.write(data,0,size);
            size=is.read(data);
        }
        //关闭这些流
        is.close();
        bos.flush();
        bos.close();
    }

    @RequestMapping("/modifyStatus")
    @ResponseBody
    public ResponseResult modifyStatus(int id) {
        if(userService.modifyStatus(id)==1){
            return  ResponseResult.success("更新用户状态成功");}
        else {
            return  ResponseResult.fail("更新用户状态失败");
        }
    }

    @RequestMapping("/deleteById")
    @ResponseBody
    public ResponseResult deleteById(int id) {
        try {
            int result = userService.deleteById(id);
            if(result==1){
            return  ResponseResult.success("删除成功");
            }else {
                return  ResponseResult.fail("删除失败");
            }
        }catch (Exception e){
            return  ResponseResult.fail("删除失败");
        }
    }


    @RequestMapping("/modify")
    public String modify(UserVo userVo,Integer pageNum, HttpSession session,Model model) {
        System.out.println("23256+5+");
        UserDto userDto = new UserDto();
        try {
            //将vo中属性值对应的拷贝到dto的相关属性中(属性必须一一对应),获取部分值
            PropertyUtils.copyProperties(userDto, userVo);
            //获取原始文件名
            userDto.setFileName(userVo.getFile().getOriginalFilename());
            userDto.setInputStream(userVo.getFile().getInputStream());
            //productDto.setUploadPath(uploadPath);
            userService.modify(userDto);
            model.addAttribute("successMsg","修改成功");
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
        }
        //返回列表页面
        return "forward:findAllByPage?pageNum="+pageNum;//转发到findAll请求
    }

}
