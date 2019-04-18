package com.wzm.zjob.dao;

import com.wzm.zjob.entity.Company;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CompanyDao {
    public List<Company> selectAll();

    public int insert(Company company);

    public List<Company> selectEnable(int valid);

    public Company selectByCompanyNameAndId(@Param("companyName") String companyName, @Param("id") Integer id);

    public int updateStatus(int id);

    public Company selectById(int id);

    public int deleteById(int id);

    public int update(Company company);

    public Company selectByLoginNameAndPassword(@Param("loginName") String loginName,@Param("password") String password, @Param("status") int status);

    public void updatePwd(@Param("id") Integer id, @Param("newPass") String newPass);

    public void reducePositionNum(Integer id);

    public void updatePositionNum(@Param("companyId") Integer companyId,@Param("positionNumTotal") Integer positionNumTotal);

    public Company selectByCompanyName(String companyName);
}
