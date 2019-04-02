package com.wzm.zjob.service;

import com.github.pagehelper.PageInfo;
import com.wzm.zjob.entity.Order;

public interface OrderService {
    public PageInfo<Order> findAllByPage(Integer pageNum, int pageSize);
}
