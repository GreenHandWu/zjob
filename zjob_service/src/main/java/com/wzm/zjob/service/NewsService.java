package com.wzm.zjob.service;

import com.github.pagehelper.PageInfo;
import com.wzm.zjob.entity.News;

public interface NewsService {
    public PageInfo<News> findAllByPage(Integer pageNum, int pageSize);

    public int add(News news);

    public boolean checkTitle(String newsTitle, Integer id);

    public int deleteById(int id);

    public int modifyStatus(int id);

    public News findById(int id);

    public int modify(News news);
}
