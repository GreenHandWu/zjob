package com.wzm.zjob.service;

import com.github.pagehelper.PageInfo;
import com.wzm.zjob.entity.Position;
import com.wzm.zjob.params.JobParam;

import java.util.List;

public interface PositionService {
    public PageInfo<Position> findAllByPage(Integer pageNum, int pageSize);

    public int add(Position position);

    public int modifyStatus(int id);

    public int deleteById(int id);

    public Position findById(int id);

    public int modify(Position position);

    public  List<Position> findByParams(JobParam jobParam);

    public  PageInfo<Position> findAllByPageAndCompanyId(Integer pageNum, int pageSize, Integer id);
}
