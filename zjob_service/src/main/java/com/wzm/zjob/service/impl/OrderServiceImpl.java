package com.wzm.zjob.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wzm.zjob.dao.OrderDao;
import com.wzm.zjob.dao.ProductDao;
import com.wzm.zjob.entity.Order;
import com.wzm.zjob.entity.Product;
import com.wzm.zjob.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {
    @Autowired
    private OrderDao orderDao;
    @Autowired
    private ProductDao productDao;
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

    @Override
    public void insert(Integer companyId, Integer productId, Integer positionNum, Date createDate) {
        Product product = productDao.selectById(productId);
        double orderSum = product.getPositionNum()*positionNum;
        orderDao.insert(companyId,productId,positionNum,orderSum,createDate);
    }

    @Override
    public int checkOrder(Integer companyId, Integer productId, Integer positionNum, Date createDate) {
        return orderDao.selectByParams(companyId,productId,positionNum,createDate);
    }
}
