package com.wzm.zjob.dao;

import com.wzm.zjob.entity.News;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface NewsDao {

    public List<News> selectAll();

    public News selectByTitle(String newsTitle);

    public News selectByTitleAndId(@Param("newsTitle") String newsTitle,@Param("id") Integer id);

    public int insert(News news);

    public int deleteById(int id);

    public int updateStatus(@Param("id") int id, @Param("newsStatus") Integer status);

    public News selectById(int id);

    public int update(News news);

    public  List<News> selectAllAndEnable(int valid);
}
