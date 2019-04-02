package com.wzm.zjob.dao;

import com.wzm.zjob.entity.Sysuser;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SysuserDao {
    public Sysuser selectByLoginNameAndPassword(@Param("loginName") String loginName, @Param("password") String password, @Param("isValid") int isValid);

    public List<Sysuser> selectAll();

    public Sysuser selectByLoginNameAndId(@Param("loginName") String loginName, @Param("id") Integer id);

    public Sysuser selectById(int id);

    public int insert(Sysuser sysuser);

    public int updateStatus(int id);

    public int update(Sysuser sysuser);
}
