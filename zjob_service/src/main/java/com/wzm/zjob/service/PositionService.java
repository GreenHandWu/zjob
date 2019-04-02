package com.wzm.zjob.service;

import com.github.pagehelper.PageInfo;
import com.wzm.zjob.entity.Position;

public interface PositionService {
    public PageInfo<Position> findAllByPage(Integer pageNum, int pageSize);

    public int add(Position position);

    public int modifyStatus(int id);

    public int deleteById(int id);

    public Position findById(int id);

    public int modify(Position position);
}
