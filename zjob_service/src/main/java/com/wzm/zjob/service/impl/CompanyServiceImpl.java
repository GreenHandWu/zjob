package com.wzm.zjob.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wzm.zjob.Constants.Constant;
import com.wzm.zjob.dao.CompanyDao;
import com.wzm.zjob.dao.ProductDao;
import com.wzm.zjob.dto.CompanyDto;
import com.wzm.zjob.entity.Company;
import com.wzm.zjob.entity.Sysuser;
import com.wzm.zjob.exception.*;
import com.wzm.zjob.ftp.FtpConfig;
import com.wzm.zjob.ftp.FtpUtils;
import com.wzm.zjob.service.CompanyService;
import com.wzm.zjob.utils.StringUtils;
import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.DigestUtils;

import java.io.IOException;
import java.util.List;

@Service
@Transactional
public class CompanyServiceImpl implements CompanyService {
    @Autowired
    private CompanyDao companyDao;
    @Autowired
    private ProductDao productDao;
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
            company.setPassword(DigestUtils.md5DigestAsHex("123".getBytes()));
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
    public int deleteById(int id) throws FileDeleteException {
        Company company = companyDao.selectById(id);
        String companyLogo = company.getCompanyLogo();
        String fileName = companyLogo.substring(companyLogo.lastIndexOf("/") + 1);
        String[] split = companyLogo.split("/");
        String filePath ="/"+ split[split.length-2];
        try {
            boolean a = FtpUtils.deleteFile(ftpConfig.getFTP_ADDRESS(), ftpConfig.getFTP_PORT(), ftpConfig.getFTP_USERNAME(), ftpConfig.getFTP_PASSWORD(), ftpConfig.getFTP_BASEPATH(), filePath, fileName);
        }catch (Exception e){
            throw new FileDeleteException("文件删除失败:" + e.getMessage());
        }
        return companyDao.deleteById(id);
    }

    @Override
    public int modifyStatus(int id) {
        return companyDao.updateStatus(id);
    }

    @Override
    public Company findById(int id) {
        return companyDao.selectById(id);
    }

    @Override
    public void modify(CompanyDto companyDto) throws FileUploadException, FileDeleteException {
        Company company = companyDao.selectById(companyDto.getId());
        String companyLogo = company.getCompanyLogo();
        String fileName = companyLogo.substring(companyLogo.lastIndexOf("/") + 1);
        String[] split = companyLogo.split("/");
        String filePath ="/"+ split[split.length-2];
        try {
            boolean a = FtpUtils.deleteFile(ftpConfig.getFTP_ADDRESS(), ftpConfig.getFTP_PORT(), ftpConfig.getFTP_USERNAME(), ftpConfig.getFTP_PASSWORD(), ftpConfig.getFTP_BASEPATH(), filePath, fileName);
        }catch (Exception e){
            throw new FileDeleteException("文件删除失败:" + e.getMessage());
        }

        //获取文件名
        //处理该文件名，通过一种方式获取一个尽可能不冲突的文件名
        fileName = StringUtils.renameFileName(companyDto.getFileName());
        //String filePath = productDto.getUploadPath() + "\\" + fileName;
        //获取ftp服务器上的二级目录
        String picSavePath = "/logo";
        filePath="";
        //上传文件
        try {
            //StreamUtils.copy(productDto.getInputStream(), new FileOutputStream(filePath));
            filePath = FtpUtils.pictureUploadByConfig(ftpConfig, fileName, picSavePath, companyDto.getInputStream());
        } catch (IOException e) {
            throw new FileUploadException("文件上传失败:" + e.getMessage());
        }
        //将相关值保存到数据库
        //dto--->pojo
        company = new Company();
        try {
            PropertyUtils.copyProperties(company, companyDto);
            company.setCompanyLogo(filePath);
            companyDao.update(company);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }




    @Override
    public List<Company> findEnable(int valid) {
        return companyDao.selectEnable(valid);
    }

    @Override
    public Company findByLoginNameAndPassowrd(String loginName, String password) throws SysuserNotExistException {
        Company company= companyDao.selectByLoginNameAndPassword(loginName, DigestUtils.md5DigestAsHex(password.getBytes()), Constant.SYSUSER_VALID);
        if(company!=null){
            return company;
        }
        throw  new SysuserNotExistException("用户名或密码不正确");
    }

    @Override
    public int add(Company company) {
        company.setPassword(DigestUtils.md5DigestAsHex(company.getPassword().getBytes()));
        company.setCompanyStatus(Constant.VALID);
        company.setPositionNum(0);
        return companyDao.insert(company);
    }
    @Override
    public void modifyPwd(Integer id, String oldPass, String newPass) throws PasswordWrongException {
        if(!companyDao.selectById(id).getPassword().equals(DigestUtils.md5DigestAsHex(oldPass.getBytes()))){
            throw new PasswordWrongException("密码错误");
        }else {
            companyDao.updatePwd(id,DigestUtils.md5DigestAsHex(newPass.getBytes()));
        }
    }

    @Override
    public void reducePositionNum(Integer id) throws PositionNumException {
        int i = companyDao.selectById(id).getPositionNum();
        if(i<=0){
            throw new PositionNumException("请购买服务");
        }
       companyDao.reducePositionNum(id);
    }

    @Override
    public void modifyPositionNum(Integer companyId, Integer productId, Integer positionNum) {
        Integer positionNumGe = productDao.selectById(productId).getPositionNum();
        Integer positionNumTotal = positionNumGe*positionNum;
        companyDao.updatePositionNum(companyId,positionNumTotal);
    }
}
