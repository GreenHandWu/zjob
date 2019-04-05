package com.wzm.zjob.dao;

import com.wzm.zjob.entity.Order;

import java.util.List;

public interface OrderDao {
    public List<Order> selectAll();

    public List<Order> selectAllByCompanyId(Integer id);
}
