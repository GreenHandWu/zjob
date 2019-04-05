package com.wzm.zjob.backend.controller;

import com.github.pagehelper.PageInfo;
import com.wzm.zjob.Constants.Constant;
import com.wzm.zjob.Constants.ResponseResult;
import com.wzm.zjob.backend.vo.CompanyVo;
import com.wzm.zjob.dto.CompanyDto;
import com.wzm.zjob.entity.Company;
import com.wzm.zjob.service.CompanyService;
import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/backend/company")
public class CompanyController {
    @Autowired
    private CompanyService companyService;
    @RequestMapping("/findAllByPage")
    //分页查询记录
    public String findAllByPage(Integer pageNum, Model model) {

        if (ObjectUtils.isEmpty(pageNum)) {
            pageNum = Constant.PAGE_NUM;
        }
        //调用service获取新闻列表
        PageInfo<Company> pageInfo = companyService.findAllByPage(pageNum, Constant.PAGE_SIZE);
        //将该列表存入model,相当于request
        model.addAttribute("data", pageInfo);
        //返回产品新闻管理视图
        return "companyManager";
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

    @RequestMapping("/add")
    //表单值通过name值与参数一一对应，
    public String add(CompanyVo companyVo, Integer pageNum, HttpSession session, Model model){
        CompanyDto companyDto = new CompanyDto();
        Date companyCreateDate = companyVo.getCompanyCreateDate();
        Calendar cal = Calendar.getInstance();
        cal.setTime(companyCreateDate);//date 换成已经已知的Date对象
        cal.add(Calendar.HOUR_OF_DAY, 8);// before 8 hour

        companyVo.setCompanyCreateDate(cal.getTime());
        try {
            //将vo中属性值对应的拷贝到dto的相关属性中(属性必须一一对应),获取部分值
            PropertyUtils.copyProperties(companyDto, companyVo);
            //获取原始文件名
            companyDto.setFileName(companyVo.getFile().getOriginalFilename());
            companyDto.setInputStream(companyVo.getFile().getInputStream());
            //productDto.setUploadPath(uploadPath);
            companyService.add(companyDto);
            model.addAttribute("successMsg","添加成功");
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
        }

        //返回列表页面
        return "forward:findAllByPage?pageNum="+pageNum;//转发到findAll请求
    }

    @RequestMapping("checkCompanyName")
    @ResponseBody
    //自动将被校验的值注入
    public Map<String, Object> checkTitle(String companyName, Integer id) {
        Map<String, Object> map = new HashMap<>();
        boolean res = companyService.checkCompanyName(companyName,id);
        //如果不存在该标题，可用
        if (res) {
            map.put("valid", true);
        } else {
            map.put("valid", false);
            map.put("message", "公司【" + companyName + "】已经存在");
        }
        return map;

    }

    @RequestMapping("/modifyStatus")
    @ResponseBody
    public ResponseResult modifyStatus(int id) {
        if(companyService.modifyStatus(id)==1){
            return  ResponseResult.success("更新新闻状态成功");}
        else {
            return  ResponseResult.fail("更新新闻状态失败");
        }
    }

    @RequestMapping("/deleteById")
    @ResponseBody
    public ResponseResult deleteById(int id) {
        try {
            int result = companyService.deleteById(id);
            if(result==1){
                return  ResponseResult.success("删除成功");
            }else {
                return  ResponseResult.fail("删除失败");
            }
        }catch (Exception e){
            return  ResponseResult.fail("删除失败");
        }
    }

    @RequestMapping("/findById")
    @ResponseBody
    public ResponseResult findById(int id) {
        Company company = companyService.findById(id);
        return  ResponseResult.success(company);
    }
    @RequestMapping("/modify")
    public String modify(CompanyVo companyVo,Integer pageNum,Model model) {
        CompanyDto companyDto = new CompanyDto();
        Date companyCreateDate = companyVo.getCompanyCreateDate();
        Calendar cal = Calendar.getInstance();
        cal.setTime(companyCreateDate);//date 换成已经已知的Date对象
        cal.add(Calendar.HOUR_OF_DAY, 8);// before 8 hour
        companyVo.setCompanyCreateDate(cal.getTime());
        try {
            PropertyUtils.copyProperties(companyDto, companyVo);
            companyDto.setFileName(companyVo.getFile().getOriginalFilename());
            companyDto.setInputStream(companyVo.getFile().getInputStream());
            companyService.modify(companyDto);
            model.addAttribute("successMsg","修改成功");
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
        }
        return "forward:findAllByPage?pageNum="+pageNum;//转发到findAll请求
    }


}
