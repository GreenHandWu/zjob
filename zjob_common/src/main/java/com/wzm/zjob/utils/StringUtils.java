package com.wzm.zjob.utils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

/**
 * Author:hellboy
 * Date:2018-11-06 16:21
 * Description:这是一个工具类，用于处理字符串相关的逻辑
 */
public class StringUtils {

    //a/b/c/d/hello.jpg
    //dfdgfgfgfdg.jpg
    public static String renameFileName(String fileName){

        int dotIndex = fileName.lastIndexOf(".");
        //获取文件类型
        String suffix = fileName.substring(dotIndex);
        return new SimpleDateFormat("yyyyMMddHHmmss").format(new Date())+
                new Random().nextInt(100)+suffix;



    }

    //通过hashcode获取二级目录
    public static String generateRandomDir(String fileName){
        int hashCode = fileName.hashCode();
        //获得一级目录
        //得到1-16以内数字的文件夹
        int dir1= hashCode & 0xf;

        //得到1-16以内数字的下级目录的文件夹
      //  int dir2=(hashCode & 0xf0)>>4;
        return  "/"+dir1;

    }

    public static void main(String[] args) {
        String dirName= generateRandomDir("mike");
        System.out.println(dirName);
    }
}
