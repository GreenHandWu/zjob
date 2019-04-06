package com.wzm.zjob.service;

import com.github.pagehelper.PageInfo;
import com.wzm.zjob.entity.Order;

import java.util.Date;
import java.util.List;

public interface OrderService {
    public PageInfo<Order> findAllByPage(Integer pageNum, int pageSize);

    public List<Order> findAll();

    PageInfo<Order> findAllByPageAndCompanyId(Integer pageNum, int pageSize, Integer id);

    public void insert(Integer companyId, Integer productId, Integer positionNum, Date createDate);

    public int checkOrder(Integer companyId, Integer productId, Integer positionNum, Date createDate);
}
