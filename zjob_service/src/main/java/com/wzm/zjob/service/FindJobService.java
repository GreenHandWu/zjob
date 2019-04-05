package com.wzm.zjob.service;

import com.wzm.zjob.entity.FindJob;

import java.util.Date;
import java.util.List;

public interface FindJobService {
    public int add(int id, Integer id1, int invalid, Date time);

    public List<FindJob> findByUserId(Integer id);
}
