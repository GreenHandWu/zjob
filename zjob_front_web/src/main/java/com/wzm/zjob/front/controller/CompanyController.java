package com.wzm.zjob.front.controller;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wzm.zjob.Constants.Constant;
import com.wzm.zjob.Constants.ResponseResult;
import com.wzm.zjob.dto.CompanyDto;
import com.wzm.zjob.entity.*;
import com.wzm.zjob.front.vo.CompanyVo;
import com.wzm.zjob.front.vo.EmailVo;
import com.wzm.zjob.service.*;
import com.wzm.zjob.utils.QQMailUtil;
import com.wzm.zjob.utils.QRCodeUtil;
import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.*;
import java.net.URL;
import java.net.URLConnection;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/front/company")
public class CompanyController {
    @Autowired
    private CompanyService companyService;
    @Autowired
    private PositionService positionService;
    @Autowired
    private OrderService orderService;

    @Autowired
    private FindJobService findJobService;
    @Autowired
    private UserService userService;
    @Autowired
    private ProductService productService;
    @Autowired
    private DateService dateService;
    @RequestMapping("checkCompanyName")
    @ResponseBody
    //自动将被校验的值注入
    public Map<String, Object> checkTitle(String companyName, Integer id) {
        Map<String, Object> map = new HashMap<>();
        boolean res = companyService.checkCompanyName(companyName, id);
        //如果不存在该标题，可用
        if (res) {
            map.put("valid", true);
        } else {
            map.put("valid", false);
            map.put("message", "公司【" + companyName + "】已经存在");
        }
        return map;

    }

    @RequestMapping("/registe")
    public String registe(Company company, Model model) {
        int res = companyService.add(company);
        if (res == 1) {
            model.addAttribute("error", "注册成功");
        } else {
            model.addAttribute("error", "注册失败");
        }
        return "login";
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

    @RequestMapping("/findPositionAllByPage")
    //分页查询记录
    public String findPositionAllByPage(Integer pageNum, Model model, HttpSession session) {
        Company company = (Company) session.getAttribute("company");
        Integer id = company.getId();
        if (ObjectUtils.isEmpty(pageNum)) {
            pageNum = Constant.PAGE_NUM;
        }
        //调用service获取新闻列表
        PageInfo<Position> pageInfo = positionService.findAllByPageAndCompanyId(pageNum, Constant.PAGE_SIZE, id);
        //将该列表存入model,相当于request
        model.addAttribute("data", pageInfo);
        //返回产品新闻管理视图
        return "/company/positionManager";
    }


    @RequestMapping("/addPosition")
    @ResponseBody
    public ResponseResult addPosition(Position position, HttpSession session) {
        Company company = (Company) session.getAttribute("company");
        position.setCompany(company);
        position.setStatus(Constant.VALID);
        if (positionService.add(position) == 1) {
            return ResponseResult.success("添加成功");
        } else {
            return ResponseResult.fail("添加失败");
        }
    }


    @RequestMapping("/findPositionById")
    @ResponseBody
    public ResponseResult findPositionById(int id) {
        Position position = positionService.findById(id);
        return ResponseResult.success(position);
    }

    @RequestMapping("/modifyPosition")
    @ResponseBody
    public ResponseResult modifyPosition(Position position, HttpSession session) {
        Company company = (Company) session.getAttribute("company");
        position.setCompany(company);

        positionService.modify(position);
        return ResponseResult.success("修改成功");
    }

    @RequestMapping("/deletePositionById")
    @ResponseBody
    public ResponseResult deletePositionById(int id) {
        try {
            positionService.deleteById(id);
            return ResponseResult.success("删除成功");
        } catch (Exception e) {
            return ResponseResult.fail("删除失败");
        }
    }

    @RequestMapping("/modifyPositionStatus")
    @ResponseBody
    public ResponseResult modifyPositionStatus(int id) {
        if (positionService.modifyStatus(id) == 1) {
            return ResponseResult.success("更新职位状态成功");
        } else {
            return ResponseResult.fail("更新职位状态失败");
        }
    }


    @RequestMapping("/findMyData")
    //分页查询记录
    public String findMyData(Model model, HttpSession session) {
        return "/company/mydata";
    }

    @RequestMapping("/modifyCompany")
    public String modifyCompany(CompanyVo companyVo, Model model, HttpSession session) {
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
            model.addAttribute("successMsg", "修改成功");
            Company company = companyService.findById(companyVo.getId());
            session.setAttribute("company", company);
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
        }
        return "/company/mydata";
    }

    @RequestMapping("/findOrderAllByPage")
    //分页查询记录
    public String findOrderAllByPage(Integer pageNum, Model model, HttpSession session) {
        Company company = (Company) session.getAttribute("company");
        if (ObjectUtils.isEmpty(pageNum)) {
            pageNum = Constant.PAGE_NUM;
        }
        Integer id = company.getId();
        //调用service获取新闻列表
        PageInfo<Order> pageInfo = orderService.findAllByPageAndCompanyId(pageNum, Constant.PAGE_SIZE, id);
        //将该列表存入model,相当于request
        model.addAttribute("data", pageInfo);
        //返回产品新闻管理视图
        return "/company/orderManager";
    }

    @RequestMapping("/toModifyCompanyPwd")
    public String toModifyCompanyPwd(Model model, HttpSession session) {
        return "/company/password";
    }

    @RequestMapping("modifyCompanyPwd")
    @ResponseBody
    public String modifyCompanyPwd(Integer id, String oldPass, String newPass) {
        try {
            companyService.modifyPwd(id, oldPass, newPass);
            return "success";
        } catch (Exception e) {
            return "fail";
        }
    }

    @RequestMapping("/findResumeAllByPage")
    //分页查询记录
    public String findResumeAllByPage(Integer pageNum, Model model, HttpSession session) {
        Company company = (Company) session.getAttribute("company");
        Integer companyId = company.getId();
        if (ObjectUtils.isEmpty(pageNum)) {
            pageNum = Constant.PAGE_NUM;
        }
        PageHelper.startPage(pageNum, Constant.PAGE_SIZE);
        List<FindJob> findJobList = findJobService.findByCompanyId(companyId);
        PageInfo<FindJob> pageInfo = new PageInfo<>(findJobList);
        model.addAttribute("data", pageInfo);
        //返回产品新闻管理视图
        return "/company/resume";
    }


    @RequestMapping("/sendEmail")
    @ResponseBody
    public ResponseResult sendMail(EmailVo emailVo,HttpSession session) {
        Company company = (Company) session.getAttribute("company");
        User user = userService.findById(emailVo.getUserId());
        try{
            companyService.reducePositionNum(company.getId());
        String context = "测试代码"+"<br/>"+
                company.getCompanyName()+"的面试通知\n" +"<br/>"+
                user.getUserName()+ "\n"+"<br/>"+
                "面试职位\n" +emailVo.getPositionName()+"<br/>"+
                "面试时间：\n" +emailVo.getTime()+"<br/>"+
                "面试地点：\n" +emailVo.getVenue()+"<br/>"+
                "通知内容：\n" +"<br/>"+
                "我们已经通过zjob招聘网查阅了您的简历。在认真阅读及评估您的简历后，我们认为您符合本公司基本条件要求。" +"<br/>"+
                "为进一步增加双方间的了解，希望您能够前往本公司面试。\n" +"<br/>"+
                "如因未及时查看通知内容而错过面试时间，请来电另约";
            QQMailUtil.QQmail("面试通知",user.getEmail(),context );
            Integer positionId = emailVo.getPositionId();
                    Integer userId = emailVo.getUserId();
                   Integer IsSend = Constant.VALID;
            findJobService.sendEmail(positionId,userId,IsSend);
            return ResponseResult.success("邮件发送成功");
        }catch (Exception e){
            return ResponseResult.fail("邮件发送失败"+e.getMessage());
        }
    }

    @RequestMapping("/findProductAllByPage")
    public String findProductAllByPage(Integer pageNum, Model model, HttpSession session) {
        if (ObjectUtils.isEmpty(pageNum)) {
            pageNum = Constant.PAGE_NUM;
        }
        //调用service获取新闻列表
        PageInfo<Product> pageInfo = productService.findAllByPage(pageNum, Constant.PAGE_SIZE);
        //将该列表存入model,相当于request
        model.addAttribute("data", pageInfo);
        //返回产品新闻管理视图
        return "/company/shop";
    }

    @RequestMapping("/findProductById")
    @ResponseBody
    public ResponseResult findProductById(int id) {
        Product product = productService.findById(id);
        return  ResponseResult.success(product);
    }
    @RequestMapping("/shop")
    @ResponseBody
    public String shop(Integer productId,Integer companyId,Integer positionNum,Date createDate) {
        String url ="productId="+productId+"&companyId="+companyId+"&positionNum="+positionNum+"&createTime="+createDate.getTime();
        String urlshow = "http://192.168.0.109:9999/zshop_front_web/front/company/createOrder?"+url;
        System.out.println(urlshow);
        Random random = new Random();
        String fileName = String.valueOf(random.nextInt(100));
        QRCodeUtil.zxingCodeCreate(urlshow,fileName,"D:\\temp\\",250,"D:\\logo.png");
        return fileName;
    }
//    shopQR
@RequestMapping("/showQR")
public void showQR(HttpServletRequest request, HttpServletResponse response, String image) throws IOException {
    // 本地文件路径
    String filePath = "D:"+ File.separator+"temp"+File.separator+image+".jpg";
    File file = new File(filePath);
    // 获取输出流
    OutputStream outputStream = response.getOutputStream();
    FileInputStream fileInputStream = new FileInputStream(file);
    // 读数据
    byte[] data = new byte[fileInputStream.available()];
    fileInputStream.read(data);
    fileInputStream.close();
    // 回写
    response.setContentType("image/jpeg;charset=utf-8");
    outputStream.write(data);
    outputStream.flush();
    outputStream.close();
}

    @RequestMapping("/createOrder")
    public String createOrder(Integer productId,Integer companyId,Integer positionNum,long createTime) {
        Date createdate = new Date(createTime);
        Calendar cal = Calendar.getInstance();
        cal.setTime(createdate);
        cal.add(Calendar.HOUR, 8);// 24小时制
        createdate = cal.getTime();
        orderService.insert(companyId,productId,positionNum,createdate);
        companyService.modifyPositionNum(companyId,productId,positionNum);
     return "/company/paysuccess";
    }


    @RequestMapping("/checkOrder")
    @ResponseBody
    public String checkOrder(Integer productId,Integer companyId,Integer positionNum,Date createDate) {
        long a = createDate.getTime();
        Date createTime = new Date(a);
        Calendar cal = Calendar.getInstance();
        cal.setTime(createTime);
        cal.add(Calendar.HOUR, 8);// 24小时制
        createTime = cal.getTime();
        int flag = orderService.checkOrder(companyId, productId, positionNum, createTime);
        System.out.println(flag);
        if (flag>0){
            return "success";
        }else{
            return "false";
        }
    }

}
