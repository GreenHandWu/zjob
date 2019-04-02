package com.wzm.zjob.dao;

import com.wzm.zjob.entity.Company;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CompanyDao {
    public List<Company> selectAll();

    public void insert(Company company);

    public List<Company> selectEnable(int valid);

    public Company selectByCompanyNameAndId(@Param("companyName") String companyName, @Param("id") Integer id);
}
