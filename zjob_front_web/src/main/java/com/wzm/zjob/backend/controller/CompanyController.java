package com.wzm.zjob.backend.controller;

import com.wzm.zjob.entity.Company;
import com.wzm.zjob.service.CompanyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/front/company")
public class CompanyController {
    @Autowired
    private CompanyService companyService;
    @RequestMapping("/checkCompanyName")
    @ResponseBody
    public Map<String,Object> checkCompanyName(String companyName){
        Map<String,Object> map = new HashMap<>();
        boolean res= companyService.checkCompanyName(companyName,null);
        //如果名字不存在，可用
        if(res){
            map.put("valid",true);
        }
        else{
            //当valid值为true,不输出消息，为false,输出message所对应的值
            map.put("valid",false);
            map.put("message","公司("+companyName+")已经存在");
        }
        return  map;

    }
    @RequestMapping("/registe")
    public String registe(Company company, Model model){
        int res = companyService.add(company);
        if(res==1){
            model.addAttribute("error","注册成功");
        }else {
            model.addAttribute("error", "注册失败");
        }
       return  "login";
    }


    @RequestMapping("/showPic")
    public void showPic(String image, OutputStream out) throws IOException {

        //将http请求读取为流
        URL url = new URL(image);
        URLConnection urlConnection = url.openConnection();
        InputStream is = urlConnection.getInputStream();

        BufferedOutputStream bos = new BufferedOutputStream(out);

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


}
