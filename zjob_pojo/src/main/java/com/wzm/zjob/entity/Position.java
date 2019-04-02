package com.wzm.zjob.entity;

import java.io.Serializable;

public class Position implements Serializable {
    private Integer id;

    private String positionName;

    private Double positionSalary;

    private Integer positionNum;

    private String positionRequire;

    private String positionEdu;

    private Company company;

    private String positionPhone;

    private Integer status;

    public Position() {
    }

    public Position(Integer id, String positionName, Double positionSalary, Integer positionNum, String positionRequire, String positionEdu, Company company, String positionPhone, Integer status) {
        this.id = id;
        this.positionName = positionName;
        this.positionSalary = positionSalary;
        this.positionNum = positionNum;
        this.positionRequire = positionRequire;
        this.positionEdu = positionEdu;
        this.company = company;
        this.positionPhone = positionPhone;
        this.status = status;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPositionName() {
        return positionName;
    }

    public void setPositionName(String positionName) {
        this.positionName = positionName;
    }

    public Double getPositionSalary() {
        return positionSalary;
    }

    public void setPositionSalary(Double positionSalary) {
        this.positionSalary = positionSalary;
    }

    public Integer getPositionNum() {
        return positionNum;
    }

    public void setPositionNum(Integer positionNum) {
        this.positionNum = positionNum;
    }

    public String getPositionRequire() {
        return positionRequire;
    }

    public void setPositionRequire(String positionRequire) {
        this.positionRequire = positionRequire;
    }

    public String getPositionEdu() {
        return positionEdu;
    }

    public void setPositionEdu(String positionEdu) {
        this.positionEdu = positionEdu;
    }

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }

    public String getPositionPhone() {
        return positionPhone;
    }

    public void setPositionPhone(String positionPhone) {
        this.positionPhone = positionPhone;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Position{" +
                "id=" + id +
                ", positionName='" + positionName + '\'' +
                ", positionSalary=" + positionSalary +
                ", positionNum=" + positionNum +
                ", positionRequire='" + positionRequire + '\'' +
                ", positionEdu='" + positionEdu + '\'' +
                ", company=" + company +
                ", positionPhone='" + positionPhone + '\'' +
                ", status=" + status +
                '}';
    }
}