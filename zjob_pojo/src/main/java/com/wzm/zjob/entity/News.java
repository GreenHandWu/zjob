package com.wzm.zjob.entity;

import java.io.Serializable;
import java.util.Date;

public class News implements Serializable {
    private Integer id;

    private Sysuser sysuser;

    private String newsTitle;

    private String newsContent;

    private Date createDate;

    private Integer newsStatus;

    public News() {
    }

    public News(Integer id, Sysuser sysuser, String newsTitle, String newsContent, Date createDate, Integer newsStatus) {
        this.id = id;
        this.sysuser = sysuser;
        this.newsTitle = newsTitle;
        this.newsContent = newsContent;
        this.createDate = createDate;
        this.newsStatus = newsStatus;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Sysuser getSysuser() {
        return sysuser;
    }

    public void setSysuser(Sysuser sysuser) {
        this.sysuser = sysuser;
    }

    public String getNewsTitle() {
        return newsTitle;
    }

    public void setNewsTitle(String newsTitle) {
        this.newsTitle = newsTitle;
    }

    public String getNewsContent() {
        return newsContent;
    }

    public void setNewsContent(String newsContent) {
        this.newsContent = newsContent;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Integer getNewsStatus() {
        return newsStatus;
    }

    public void setNewsStatus(Integer newsStatus) {
        this.newsStatus = newsStatus;
    }

    @Override
    public String toString() {
        return "News{" +
                "id=" + id +
                ", sysuser=" + sysuser +
                ", newsTitle='" + newsTitle + '\'' +
                ", newsContent='" + newsContent + '\'' +
                ", createDate=" + createDate +
                ", newsStatus=" + newsStatus +
                '}';
    }
}