package com.wzm.zjob.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wzm.zjob.Constants.Constant;
import com.wzm.zjob.dao.NewsDao;
import com.wzm.zjob.entity.News;
import com.wzm.zjob.service.NewsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class NewsServiceImpl implements NewsService {
    @Autowired
    private NewsDao newsDao;

    @Override
    public PageInfo<News> findAllByPage(Integer pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<News> newsList = newsDao.selectAll();

        PageInfo<News> pageInfo = new PageInfo<>(newsList);
        return pageInfo;
    }

    @Override
    public int add(News news){
       return newsDao.insert(news);
    }

    @Override
    public boolean checkTitle(String newsTitle, Integer id) {
         News news;
         if(null != id){
             news= newsDao.selectByTitleAndId(newsTitle,id);
         }else{
             news= newsDao.selectByTitle(newsTitle);
         }
        if(news!=null){
            return false;
        }
        return true;
    }

    @Override
    public int deleteById(int id) {
        return newsDao.deleteById(id);
    }

    @Override
    public int modifyStatus(int id) {
        News news = newsDao.selectById(id);
        Integer status = news.getNewsStatus();
        if(status==Constant.VALID){
            status=Constant.INVALID;
        }
        else if(status==Constant.INVALID){
            status=Constant.VALID;
        }
        newsDao.updateStatus(id,status);



        return newsDao.updateStatus(id, status);
    }

    @Override
    public News findById(int id) {
        return newsDao.selectById(id);
    }

    @Override
    public int modify(News news) {
        return newsDao.update(news);
    }

    @Override
    public PageInfo<News> findAllByPageAndEnable(Integer pageNum, int pageSize, int valid) {
        PageHelper.startPage(pageNum, pageSize);
        List<News> newsList = newsDao.selectAllAndEnable(valid);

        PageInfo<News> pageInfo = new PageInfo<>(newsList);
        return pageInfo;
    }
}
