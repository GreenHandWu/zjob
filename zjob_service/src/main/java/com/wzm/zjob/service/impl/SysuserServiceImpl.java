package com.wzm.zjob.service.impl;

import com.github.pagehelper.PageInfo;
import com.wzm.zjob.Constants.Constant;
import com.wzm.zjob.exception.SysuserNotExistException;
import com.wzm.zjob.service.SysuserService;
import com.wzm.zjob.dao.SysuserDao;
import com.wzm.zjob.entity.Sysuser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.DigestUtils;

import java.util.List;

@Service
@Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
public class SysuserServiceImpl implements SysuserService {
    @Autowired
    private SysuserDao sysuserDao;
    @Override
    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    public Sysuser findByLoginNameAndPassowrd(String loginName, String password) throws SysuserNotExistException {
        Sysuser sysuser= sysuserDao.selectByLoginNameAndPassword(loginName, DigestUtils.md5DigestAsHex(password.getBytes()), Constant.SYSUSER_VALID);
        if(sysuser!=null){
            return sysuser;
        }

        throw  new SysuserNotExistException("用户名或密码不正确");
    }


    @Override
    public List<Sysuser> findAll() {
     return sysuserDao.selectAll();
    }

    @Override
    public boolean checkLoginName(String loginName, Integer id) {
        Sysuser sysuser = sysuserDao.selectByLoginNameAndId(loginName,id);
        if(sysuser!=null){
            return false;
        }
        return true;
    }

    @Override
    public Sysuser findById(int id) {
        return sysuserDao.selectById(id);
    }

    @Override
    public int add(Sysuser sysuser) {
        return sysuserDao.insert(sysuser);
    }

    @Override
    public int modifyStatus(int id) {
        return sysuserDao.updateStatus(id);
    }

    @Override
    public int modify(Sysuser sysuser) {
        return sysuserDao.update(sysuser);
    }
}
