package com.wzm.zjob.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wzm.zjob.Constants.Constant;
import com.wzm.zjob.dao.UserDao;
import com.wzm.zjob.dto.UserDto;
import com.wzm.zjob.entity.User;
import com.wzm.zjob.exception.FileDeleteException;
import com.wzm.zjob.exception.FileUploadException;
import com.wzm.zjob.exception.PasswordWrongException;
import com.wzm.zjob.exception.SysuserNotExistException;
import com.wzm.zjob.ftp.FtpConfig;
import com.wzm.zjob.ftp.FtpUtils;
import com.wzm.zjob.service.UserService;
import com.wzm.zjob.utils.StringUtils;
import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;

import java.io.IOException;
import java.util.List;
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;
    @Autowired
    private FtpConfig ftpConfig;
    @Override
    public PageInfo<User> findAllByPage(Integer pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<User> userList = userDao.selectAll();
        PageInfo<User> pageInfo = new PageInfo<>(userList);
        return pageInfo;
    }

    @Override
    public boolean checkUserName(String userName, Integer id) {
        User user;
        if(null != id){
            user= userDao.selectByUserNameAndId(userName,id);
        }else {
            user=userDao.selectByUserName(userName);
        }
        if(user!=null){
            return false;
        }
        return true;
    }

    @Override
    public int add(User user) {
        user.setUserStatus(Constant.VALID);
        user.setPassword(DigestUtils.md5DigestAsHex(user.getPassword().getBytes()));
        return userDao.insert(user);
    }

    @Override
    public User findById(int id) {
        return userDao.selectById(id);
    }

    @Override
    public int modify(User user) {
       return userDao.update(user);
    }

    @Override
    public void add(UserDto userDto) throws FileUploadException {
        //获取文件名
        //处理该文件名，通过一种方式获取一个尽可能不冲突的文件名
        String fileName = StringUtils.renameFileName(userDto.getFileName());
        //String filePath = productDto.getUploadPath() + "\\" + fileName;
        //获取ftp服务器上的二级目录
        String picSavePath = "/resume";
        String filePath="";
        //上传文件
        try {
            //StreamUtils.copy(productDto.getInputStream(), new FileOutputStream(filePath));
            filePath = FtpUtils.pictureUploadByConfig(ftpConfig, fileName, picSavePath, userDto.getInputStream());
        } catch (IOException e) {
            throw new FileUploadException("文件上传失败:" + e.getMessage());
        }
        //将相关值保存到数据库
        //dto--->pojo
        User user = new User();
        try {
            PropertyUtils.copyProperties(user, userDto);
            user.setUserStatus(Constant.VALID);
            user.setPassword(DigestUtils.md5DigestAsHex(user.getPassword().getBytes()));
            user.setUserResume(filePath);
            userDao.insert(user);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public int modifyStatus(int id) {
        return userDao.updateStatus(id);
    }

    @Override
    public int deleteById(int id) throws FileDeleteException{
        User user = userDao.selectById(id);
        String userResume = user.getUserResume();
        String fileName = userResume.substring(userResume.lastIndexOf("/") + 1);
        String[] split = userResume.split("/");
        String filePath ="/"+ split[split.length-2];
        try {
            boolean a = FtpUtils.deleteFile(ftpConfig.getFTP_ADDRESS(), ftpConfig.getFTP_PORT(), ftpConfig.getFTP_USERNAME(), ftpConfig.getFTP_PASSWORD(), ftpConfig.getFTP_BASEPATH(), filePath, fileName);
        }catch (Exception e){
            throw new FileDeleteException("文件删除失败:" + e.getMessage());
        }
        return userDao.deleteById(id);
    }

    @Override
    public void modify(UserDto userDto) throws FileUploadException, FileDeleteException {
        User user = userDao.selectById(userDto.getId());
        String userResume = user.getUserResume();
        String fileName = userResume.substring(userResume.lastIndexOf("/") + 1);
        String[] split = userResume.split("/");
        String filePath ="/"+ split[split.length-2];
        try {
            boolean a = FtpUtils.deleteFile(ftpConfig.getFTP_ADDRESS(), ftpConfig.getFTP_PORT(), ftpConfig.getFTP_USERNAME(), ftpConfig.getFTP_PASSWORD(), ftpConfig.getFTP_BASEPATH(), filePath, fileName);
        }catch (Exception e){
            throw new FileDeleteException("文件删除失败:" + e.getMessage());
        }

        //获取文件名
        //处理该文件名，通过一种方式获取一个尽可能不冲突的文件名
         fileName = StringUtils.renameFileName(userDto.getFileName());
        //String filePath = productDto.getUploadPath() + "\\" + fileName;
        //获取ftp服务器上的二级目录
        String picSavePath = "/resume";
        filePath="";
        //上传文件
        try {
            //StreamUtils.copy(productDto.getInputStream(), new FileOutputStream(filePath));
            filePath = FtpUtils.pictureUploadByConfig(ftpConfig, fileName, picSavePath, userDto.getInputStream());
        } catch (IOException e) {
            throw new FileUploadException("文件上传失败:" + e.getMessage());
        }
        //将相关值保存到数据库
        //dto--->pojo
        user = new User();
        try {
            PropertyUtils.copyProperties(user, userDto);
            if(null!=user.getPassword()){
                user.setPassword(DigestUtils.md5DigestAsHex(user.getPassword().getBytes()));
            }
            user.setUserResume(filePath);
            userDao.update(user);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public User findByLoginNameAndPassowrd(String loginName, String password) throws SysuserNotExistException {
        User user= userDao.selectByLoginNameAndPassword(loginName, DigestUtils.md5DigestAsHex(password.getBytes()), Constant.SYSUSER_VALID);
        if(user!=null){
            return user;
        }
        throw  new SysuserNotExistException("用户名或密码不正确");
    }

    @Override
    public void modifyPwd(Integer id, String oldPass, String newPass) throws PasswordWrongException {
       if(!userDao.selectById(id).getPassword().equals(DigestUtils.md5DigestAsHex(oldPass.getBytes()))){
           throw new PasswordWrongException("密码错误");
       }else {
           userDao.updatePwd(id,DigestUtils.md5DigestAsHex(newPass.getBytes()));
       }
    }

}
