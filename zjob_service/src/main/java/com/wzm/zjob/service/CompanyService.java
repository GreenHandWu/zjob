package com.wzm.zjob.service;

import com.github.pagehelper.PageInfo;
import com.wzm.zjob.dto.CompanyDto;
import com.wzm.zjob.entity.Company;
import com.wzm.zjob.exception.FileDeleteException;
import com.wzm.zjob.exception.FileUploadException;

import java.util.List;

public interface CompanyService {
    public PageInfo<Company> findAllByPage(Integer pageNum, int pageSize);

    public void add(CompanyDto companyDto) throws FileUploadException;

    public boolean checkCompanyName(String companyName,Integer id);

    public int deleteById(int id) throws FileDeleteException;

    public int modifyStatus(int id);

    public Company findById(int id);

    public void modify(CompanyDto companyDto) throws FileUploadException, FileDeleteException ;

    public List<Company> findEnable(int valid);
}
