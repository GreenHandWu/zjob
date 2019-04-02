package com.wzm.zjob.dao;

import com.wzm.zjob.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserDao {
    public List<User> selectAll();

    public User selectByUserName(String userName);

    public int insert(User user);

    public User selectById(int id);

    public int update(User user);

    public int updateStatus(int id);

    public int deleteById(Integer id);

    public User selectByUserNameAndId(@Param("userName") String userName, @Param("id") Integer id);
}
