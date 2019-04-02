package com.wzm.zjob.service.impl;

import com.wzm.zjob.dao.DateDao;
import com.wzm.zjob.service.DateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
@Service
public class DateServiceImpl implements DateService {
    @Autowired
    private DateDao dateDao;
    @Override
    public Date getTime() {
        return dateDao.selectTime();
    }
}
