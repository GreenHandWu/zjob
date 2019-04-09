package com.wzm.zjob.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wzm.zjob.dao.PositionDao;
import com.wzm.zjob.entity.Position;
import com.wzm.zjob.params.JobParam;
import com.wzm.zjob.service.PositionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class PositionServiceImpl implements PositionService {
    @Autowired
    private PositionDao positionDao;

    @Override
    public PageInfo<Position> findAllByPage(Integer pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Position> positionList = positionDao.selectAll();
        PageInfo<Position> pageInfo = new PageInfo<>(positionList);
        return pageInfo;
    }

    @Override
    public int add(Position position) {
        return positionDao.insert(position);
    }

    @Override
    public int modifyStatus(int id) {
        return positionDao.updateStatus(id);
    }

    @Override
    public int deleteById(int id) {
        return positionDao.deleteById(id);
    }

    @Override
    public Position findById(int id) {
        return positionDao.selectById(id);
    }

    @Override
    public int modify(Position position) {
        return positionDao.update(position);
    }

    @Override
    public List<Position> findByParams(JobParam jobParam) {
        return positionDao.selectByParams(jobParam);
    }

    @Override
    public PageInfo<Position> findAllByPageAndCompanyId(Integer pageNum, int pageSize, Integer id) {
        PageHelper.startPage(pageNum, pageSize);
        List<Position> positionList = positionDao.selectAllByCompanyId(id);
        PageInfo<Position> pageInfo = new PageInfo<>(positionList);
        return pageInfo;
    }
}
