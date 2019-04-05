package com.wzm.zjob.service;

import com.github.pagehelper.PageInfo;
import com.wzm.zjob.dto.UserDto;
import com.wzm.zjob.entity.User;
import com.wzm.zjob.exception.FileDeleteException;
import com.wzm.zjob.exception.FileUploadException;
import com.wzm.zjob.exception.PasswordWrongException;
import com.wzm.zjob.exception.SysuserNotExistException;

public interface UserService {
    public PageInfo<User> findAllByPage(Integer pageNum, int pageSize);

    public boolean checkUserName(String userName, Integer id);

    public int add(User user);

    public User findById(int id);

    public int modify(User user);

    public void add(UserDto userDto) throws FileUploadException;

    public int modifyStatus(int id);

    public int deleteById(int id) throws FileDeleteException;

    public void modify(UserDto userDto) throws FileUploadException, FileDeleteException;

    public User findByLoginNameAndPassowrd(String loginName, String password) throws SysuserNotExistException;

    public void modifyPwd(Integer id, String oldPass, String newPass) throws PasswordWrongException;
}
