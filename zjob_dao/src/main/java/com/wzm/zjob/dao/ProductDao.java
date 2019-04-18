package com.wzm.zjob.dao;

import com.wzm.zjob.entity.Product;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProductDao {
    public List<Product> selectAll();

    public List<Product> selectAllValid(int valid);

    public Product selectByTitleAndId(@Param("productName") String productName, @Param("id") Integer id);

    public int insert(Product product);

    public Product selectById(int id);

    public int update(Product product);

    public int deleteById(int id);

    public int updateStatus(int id);
}
