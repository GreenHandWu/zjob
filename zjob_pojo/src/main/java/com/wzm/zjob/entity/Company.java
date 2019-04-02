package com.wzm.zjob.entity;

import java.io.Serializable;
import java.util.Date;

public class Company implements Serializable {
    private Integer id;

    private String companyName;

    private String password;

    private String companyEmail;

    private String companyLogo;

    private String companyAddress;

    private String companyType;

    private String companyDesc;

    private String companyPhone;

    private Date companyCreateDate;

    private String companyPerson;

    private Integer companyStatus;

    private Integer positionNum;

    public Company() {
    }

    public Company(Integer id, String companyName, String password, String companyEmail, String companyLogo, String companyAddress, String companyType, String companyDesc, String companyPhone, Date companyCreateDate, String companyPerson, Integer companyStatus, Integer positionNum) {
        this.id = id;
        this.companyName = companyName;
        this.password = password;
        this.companyEmail = companyEmail;
        this.companyLogo = companyLogo;
        this.companyAddress = companyAddress;
        this.companyType = companyType;
        this.companyDesc = companyDesc;
        this.companyPhone = companyPhone;
        this.companyCreateDate = companyCreateDate;
        this.companyPerson = companyPerson;
        this.companyStatus = companyStatus;
        this.positionNum = positionNum;
    }

    public Company(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName == null ? null : companyName.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCompanyEmail() {
        return companyEmail;
    }

    public void setCompanyEmail(String companyEmail) {
        this.companyEmail = companyEmail == null ? null : companyEmail.trim();
    }

    public String getCompanyLogo() {
        return companyLogo;
    }

    public void setCompanyLogo(String companyLogo) {
        this.companyLogo = companyLogo == null ? null : companyLogo.trim();
    }

    public String getCompanyAddress() {
        return companyAddress;
    }

    public void setCompanyAddress(String companyAddress) {
        this.companyAddress = companyAddress == null ? null : companyAddress.trim();
    }

    public String getCompanyType() {
        return companyType;
    }

    public void setCompanyType(String companyType) {
        this.companyType = companyType == null ? null : companyType.trim();
    }

    public String getCompanyDesc() {
        return companyDesc;
    }

    public void setCompanyDesc(String companyDesc) {
        this.companyDesc = companyDesc == null ? null : companyDesc.trim();
    }

    public String getCompanyPhone() {
        return companyPhone;
    }

    public void setCompanyPhone(String companyPhone) {
        this.companyPhone = companyPhone == null ? null : companyPhone.trim();
    }

    public Date getCompanyCreateDate() {
        return companyCreateDate;
    }

    public void setCompanyCreateDate(Date companyCreateDate) {
        this.companyCreateDate = companyCreateDate;
    }

    public String getCompanyPerson() {
        return companyPerson;
    }

    public void setCompanyPerson(String companyPerson) {
        this.companyPerson = companyPerson == null ? null : companyPerson.trim();
    }

    public Integer getCompanyStatus() {
        return companyStatus;
    }

    public void setCompanyStatus(Integer companyStatus) {
        this.companyStatus = companyStatus;
    }

    public Integer getPositionNum() {
        return positionNum;
    }

    public void setPositionNum(Integer positionNum) {
        this.positionNum = positionNum;
    }

    @Override
    public String toString() {
        return "Company{" +
                "id=" + id +
                ", companyName='" + companyName + '\'' +
                ", password='" + password + '\'' +
                ", companyEmail='" + companyEmail + '\'' +
                ", companyLogo='" + companyLogo + '\'' +
                ", companyAddress='" + companyAddress + '\'' +
                ", companyType='" + companyType + '\'' +
                ", companyDesc='" + companyDesc + '\'' +
                ", companyPhone='" + companyPhone + '\'' +
                ", companyCreateDate=" + companyCreateDate +
                ", companyPerson='" + companyPerson + '\'' +
                ", companyStatus=" + companyStatus +
                ", positionNum=" + positionNum +
                '}';
    }
}