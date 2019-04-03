package com.wzm.zjob.service;

import com.github.pagehelper.PageInfo;
import com.wzm.zjob.entity.Order;

import java.util.List;

public interface OrderService {
    public PageInfo<Order> findAllByPage(Integer pageNum, int pageSize);

    public List<Order> findAll();
}
