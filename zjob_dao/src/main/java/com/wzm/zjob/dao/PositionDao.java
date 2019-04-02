package com.wzm.zjob.dao;

import com.wzm.zjob.entity.Position;

import java.util.List;

public interface PositionDao {
    public List<Position> selectAll();

    public int insert(Position position);

    public int updateStatus(int id);

    public int deleteById(int id);

    public Position selectById(int id);

    public int update(Position position);
}
