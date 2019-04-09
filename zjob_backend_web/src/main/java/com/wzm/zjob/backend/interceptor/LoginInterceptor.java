package com.wzm.zjob.backend.interceptor;

import com.wzm.zjob.entity.Sysuser;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

public class LoginInterceptor implements HandlerInterceptor {

    private List<String> passList=new ArrayList<>();

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        //允许放行的url路径
        String url=request.getRequestURI();
        System.out.println("url-->"+url);
        for(String passUrl:passList) {
            System.out.println("passUrl-->"+passUrl);
            if(url.indexOf(passUrl)>0) {
                return true;
            }
        }
        //已经登录放行
        Sysuser sysuser=(Sysuser)request.getSession().getAttribute("sysuser");
        if(sysuser!=null) {
            return true;
        }
        request.getRequestDispatcher("/showLogin").forward(request, response);
        return false;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
                           ModelAndView modelAndView) throws Exception {
        // TODO Auto-generated method stub

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
            throws Exception {
        // TODO Auto-generated method stub

    }

    public List getPassList() {
        return passList;
    }

    public void setPassList(List passList) {
        this.passList = passList;
    }



}