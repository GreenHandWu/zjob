package com.wzm.zjob.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wzm.zjob.dao.OrderDao;
import com.wzm.zjob.entity.Order;
import com.wzm.zjob.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {
    @Autowired
    private OrderDao orderDao;
    @Override
    public PageInfo<Order> findAllByPage(Integer pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Order> orderList = orderDao.selectAll();
        PageInfo<Order> pageInfo = new PageInfo<>(orderList);
        return pageInfo;
    }

    @Override
    public List<Order> findAll() {
        return orderDao.selectAll();
    }

    @Override
    public PageInfo<Order> findAllByPageAndCompanyId(Integer pageNum, int pageSize, Integer id) {
        PageHelper.startPage(pageNum, pageSize);
        List<Order> orderList = orderDao.selectAllByCompanyId(id);
        PageInfo<Order> pageInfo = new PageInfo<>(orderList);
        return pageInfo;
    }
}
