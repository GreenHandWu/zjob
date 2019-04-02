package com.wzm.zjob.service;

import com.github.pagehelper.PageInfo;
import com.wzm.zjob.entity.Sysuser;
import com.wzm.zjob.exception.SysuserNotExistException;

import java.util.List;

public interface SysuserService {
    public Sysuser findByLoginNameAndPassowrd(String loginName, String password) throws SysuserNotExistException;

    public List<Sysuser> findAll();

    public boolean checkLoginName(String loginName, Integer id);

    public Sysuser findById(int id);

    public int add(Sysuser sysuser);

    public int modifyStatus(int id);

    public int modify(Sysuser sysuser);
}
