package com.wzm.zjob.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wzm.zjob.Constants.Constant;
import com.wzm.zjob.dao.CompanyDao;
import com.wzm.zjob.dto.CompanyDto;
import com.wzm.zjob.entity.Company;
import com.wzm.zjob.exception.FileUploadException;
import com.wzm.zjob.ftp.FtpConfig;
import com.wzm.zjob.ftp.FtpUtils;
import com.wzm.zjob.service.CompanyService;
import com.wzm.zjob.utils.StringUtils;
import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;

@Service
public class CompanyServiceImpl implements CompanyService {
    @Autowired
    private CompanyDao companyDao;
    @Autowired
    private FtpConfig ftpConfig;
    @Override
    public PageInfo<Company> findAllByPage(Integer pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Company> companyList = companyDao.selectAll();
        PageInfo<Company> pageInfo = new PageInfo<>(companyList);
        return pageInfo;
    }
    @Override
    public void add(CompanyDto companyDto) throws FileUploadException {
        //获取文件名
        //处理该文件名，通过一种方式获取一个尽可能不冲突的文件名
        String fileName = StringUtils.renameFileName(companyDto.getFileName());
        //String filePath = productDto.getUploadPath() + "\\" + fileName;
        //获取ftp服务器上的二级目录
        String picSavePath = "/logo";
        String filePath="";
        //上传文件
        try {
            //StreamUtils.copy(productDto.getInputStream(), new FileOutputStream(filePath));
            filePath = FtpUtils.pictureUploadByConfig(ftpConfig, fileName, picSavePath, companyDto.getInputStream());
        } catch (IOException e) {
            throw new FileUploadException("文件上传失败:" + e.getMessage());
        }
        //将相关值保存到数据库
        //dto--->pojo
        Company company = new Company();
        try {
            PropertyUtils.copyProperties(company, companyDto);
            company.setCompanyStatus(Constant.VALID);
            company.setPositionNum(0);
            company.setCompanyLogo(filePath);
            companyDao.insert(company);
        } catch (Exception e) {
            e.printStackTrace();
        }


    }

    @Override
    public boolean checkCompanyName(String companyName,Integer id) {
        Company company = companyDao.selectByCompanyNameAndId(companyName,id);
        if(company!=null){
            return false;
        }
        return true;
    }

    @Override
    public int deleteById(int id) {
        return 0;
    }

    @Override
    public int modifyStatus(int id) {
        return 0;
    }

    @Override
    public Company findById(int id) {
        return null;
    }

    @Override
    public int modify(Company company) {
        return 0;
    }

    @Override
    public List<Company> findEnable(int valid) {
        return companyDao.selectEnable(valid);
    }
}
