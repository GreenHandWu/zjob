package com.wzm.zjob.Constants;

import java.io.Serializable;

public class ResponseResult implements Serializable {

    //状态码
    private  Integer status;

    //消息
    private String message;

    //返回数据
    private  Object obj;

    public ResponseResult() {
    }

    public ResponseResult(Integer status, String message, Object obj) {
        this.status = status;
        this.message = message;
        this.obj = obj;
    }

    public static  ResponseResult success(Object obj){
        return  new ResponseResult(Constant.RESPONSE_STATUS_SUCCESS,"success",obj);
    }
    public static  ResponseResult success(String message){
        return  new ResponseResult(Constant.RESPONSE_STATUS_SUCCESS,message,null);
    }
    public static  ResponseResult fail(String message){
        return  new ResponseResult(Constant.RESPONSE_STATUS_FAILURE,message,null);
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Object getObj() {
        return obj;
    }

    public void setObj(Object obj) {
        this.obj = obj;
    }
}
