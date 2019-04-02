package com.wzm.zjob.ftp;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;


public class Test {

    public static void testFtp(){

        //创建客户端对象
        FTPClient ftp = new FTPClient();
        InputStream local=null;
        try {
            //连接ftp服务器
            ftp.connect("47.101.128.196",21);

            //登录
            ftp.login("ftpowner","123456");
            //设置上传路径
            //注意：设置的是绝对路径，以/开头
            String path = "/home/ftpowner/2";

            //检查上传路径是否存在，如果不存在,返回false，创建上传路径
            boolean flag = ftp.changeWorkingDirectory(path);
            if(!flag){
                ftp.makeDirectory(path);
            }
            //指定上传路径
            ftp.changeWorkingDirectory(path);
            //设置上传文件的类型:二进制文件
            ftp.setFileType(FTP.BINARY_FILE_TYPE);
            //读取本地文件
            File f = new File("d:/b.txt");
            local = new FileInputStream(f);

            //获取文件的名称
            String name = f.getName();
            //上传该文件到ftp服务器
            ftp.storeFile(name,local);


        }
        catch (Exception e){

        }
        finally {


            try {
                //关闭文件流
                local.close();

                //退出ftp
                ftp.logout();
                //断开ftp连接
                ftp.disconnect();

            } catch (IOException e) {
                e.printStackTrace();
            }

        }


    }

    public static void main(String[] args) {
     boolean a = FtpUtils.deleteFile("47.101.128.196","21","ftpowner","123456","/home/ftpowner/images","/12","2019032723330846.jpg");
       System.out.println(a);

    }
}
