package com.wzm.zjob.entity;

import java.io.Serializable;

public class User implements Serializable {
    private Integer id;

    private String userName;

    private String password;

    private Integer gender;

    private String phone;

    private String userEdu;

    private String email;

    private Integer userStatus;

    private String userResume;

    public User() {
    }

    public User(Integer id, String userName, String password, Integer gender, String phone, String userEdu, String email, Integer userStatus, String userResume) {
        this.id = id;
        this.userName = userName;
        this.password = password;
        this.gender = gender;
        this.phone = phone;
        this.userEdu = userEdu;
        this.email = email;
        this.userStatus = userStatus;
        this.userResume = userResume;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Integer getGender() {
        return gender;
    }

    public void setGender(Integer gender) {
        this.gender = gender;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getUserEdu() {
        return userEdu;
    }

    public void setUserEdu(String userEdu) {
        this.userEdu = userEdu;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getUserStatus() {
        return userStatus;
    }

    public void setUserStatus(Integer userStatus) {
        this.userStatus = userStatus;
    }

    public String getUserResume() {
        return userResume;
    }

    public void setUserResume(String userResume) {
        this.userResume = userResume;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", userName='" + userName + '\'' +
                ", password='" + password + '\'' +
                ", gender=" + gender +
                ", phone='" + phone + '\'' +
                ", userEdu='" + userEdu + '\'' +
                ", email='" + email + '\'' +
                ", userStatus=" + userStatus +
                ", userResume='" + userResume + '\'' +
                '}';
    }
}
