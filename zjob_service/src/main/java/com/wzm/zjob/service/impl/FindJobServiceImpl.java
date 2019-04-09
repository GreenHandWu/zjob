package com.wzm.zjob.service.impl;

import com.wzm.zjob.dao.FindJobDao;
import com.wzm.zjob.entity.FindJob;
import com.wzm.zjob.service.FindJobService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
@Transactional
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

    @Override
    public List<FindJob> findByCompanyId(Integer companyId) {
        return findJobDao.selectAllByCompanyId(companyId);
    }

    @Override
    public void sendEmail(Integer positionId, Integer userId, Integer isSend) {
        findJobDao.updateIsSend(positionId,userId,isSend);
    }
}
