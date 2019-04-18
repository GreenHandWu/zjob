package com.wzm.zjob.service;

import com.github.pagehelper.PageInfo;
import com.wzm.zjob.dto.CompanyDto;
import com.wzm.zjob.entity.Company;
import com.wzm.zjob.exception.*;

import java.util.List;

public interface CompanyService {
    public PageInfo<Company> findAllByPage(Integer pageNum, int pageSize);

    public void add(CompanyDto companyDto) throws FileUploadException;

    public boolean checkCompanyName(String companyName, Integer id);

    public int deleteById(int id) throws FileDeleteException;

    public int modifyStatus(int id);

    public Company findById(int id);

    public void modify(CompanyDto companyDto) throws FileUploadException, FileDeleteException;

    public List<Company> findEnable(int valid);

    public Company findByLoginNameAndPassowrd(String loginName, String password) throws SysuserNotExistException;

    public int add(Company company);

    public void modifyPwd(Integer id, String oldPass, String newPass) throws PasswordWrongException;

    public void reducePositionNum(Integer id) throws PositionNumException;

    public void modifyPositionNum(Integer companyId, Integer productId, Integer positionNum);

    public Company findByCompanyName(String forgetCompanyName);

    public void modifyCompanyPassWordBySms(Company company);
}
