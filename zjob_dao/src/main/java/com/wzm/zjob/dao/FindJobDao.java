package com.wzm.zjob.dao;

import com.wzm.zjob.entity.FindJob;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface FindJobDao {
    public int insert(@Param("positionId") Integer positionId, @Param("userId") Integer userId,
                      @Param("isSend") Integer isSend, @Param("time")Date time);
    public List<FindJob> selectAllByUserId(Integer userId);

}
