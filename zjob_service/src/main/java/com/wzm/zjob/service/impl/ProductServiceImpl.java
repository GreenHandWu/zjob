package com.wzm.zjob.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wzm.zjob.dao.ProductDao;
import com.wzm.zjob.entity.Product;
import com.wzm.zjob.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class ProductServiceImpl implements ProductService {
    @Autowired
    private ProductDao productDao;
    @Override
    public PageInfo<Product> findAllByPage(Integer pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Product> productList = productDao.selectAll();
        PageInfo<Product> pageInfo = new PageInfo<>(productList);
        return pageInfo;
    }

    @Override
    public boolean checkProductName(String productName, Integer id) {
        Product product = productDao.selectByTitleAndId(productName,id);
        if(product!=null){
            return false;
        }
        return true;
    }

    @Override
    public int add(Product product) {
        return productDao.insert(product);
    }

    @Override
    public Product findById(int id) {
        return productDao.selectById(id);
    }

    @Override
    public int modify(Product product) {
        return productDao.update(product);
    }

    @Override
    public int deleteById(int id) {
        return productDao.deleteById(id);
    }
}
