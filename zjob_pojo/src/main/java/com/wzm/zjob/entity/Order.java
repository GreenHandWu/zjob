package com.wzm.zjob.entity;

import java.io.Serializable;
import java.util.Date;

public class Order implements Serializable {
    private Integer id;

    private Company company;

    private Product product;

    private Integer productNum;

    private Double orderSum;

    private Date createTime;

    public Order() {
    }

    public Order(Integer id, Company company, com.wzm.zjob.entity.Product product, Integer productNum, Double orderSum, Date createTime) {
        this.id = id;
        this.company = company;
        this.product = product;
        this.productNum = productNum;
        this.orderSum = orderSum;
        this.createTime = createTime;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }

    public com.wzm.zjob.entity.Product getProduct() {
        return this.product;
    }

    public void setProduct(com.wzm.zjob.entity.Product product) {
       this.product = product;
    }

    public Integer getProductNum() {
        return productNum;
    }

    public void setProductNum(Integer productNum) {
        this.productNum = productNum;
    }

    public Double getOrderSum() {
        return orderSum;
    }

    public void setOrderSum(Double orderSum) {
        this.orderSum = orderSum;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @Override
    public String toString() {
        return "Order{" +
                "id=" + id +
                ", company=" + company +
                ", Product=" + product +
                ", productNum=" + productNum +
                ", orderSum=" + orderSum +
                ", createTime=" + createTime +
                '}';
    }
}