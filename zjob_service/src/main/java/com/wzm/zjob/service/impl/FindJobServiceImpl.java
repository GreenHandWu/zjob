package com.wzm.zjob.service.impl;

import com.wzm.zjob.dao.FindJobDao;
import com.wzm.zjob.entity.FindJob;
import com.wzm.zjob.service.FindJobService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class FindJobServiceImpl implements FindJobService {
    @Autowired
    private FindJobDao findJobDao;

    @Override
    public int add(int posiotionId, Integer userId, int isSend, Date time) {
        return findJobDao.insert(posiotionId,userId,isSend,time);
    }

    @Override
    public List<FindJob> findByUserId(Integer id) {
        return findJobDao.selectAllByUserId(id);
    }
}
