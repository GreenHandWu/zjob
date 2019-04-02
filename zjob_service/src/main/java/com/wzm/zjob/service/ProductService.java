package com.wzm.zjob.service;

import com.github.pagehelper.PageInfo;
import com.wzm.zjob.entity.Product;

public interface ProductService {
    public PageInfo<Product> findAllByPage(Integer pageNum, int pageSize);

    public boolean checkProductName(String productName, Integer id);

    public int add(Product product);

    public Product findById(int id);

    public int modify(Product product);

    public int deleteById(int id);
}
