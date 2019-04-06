package com.wzm.zjob.dao;

import com.wzm.zjob.entity.Order;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface OrderDao {
    public List<Order> selectAll();

    public List<Order> selectAllByCompanyId(Integer id);

    public void insert(@Param("companyId") Integer companyId,
                       @Param("productId") Integer productId,
                       @Param("productNum") Integer positionNum,
                       @Param("orderSum")double orderSum,
                       @Param("createDate")Date createDate);
    public Integer  selectByParams(
            @Param("companyId") Integer companyId,
            @Param("productId") Integer productId,
            @Param("productNum") Integer positionNum,
            @Param("createDate")Date createDate
    );


}
