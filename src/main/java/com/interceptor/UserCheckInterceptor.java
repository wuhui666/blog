package com.interceptor;

import com.pojo.User;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author: wuhui
 * @time: 2019/4/1 19:06
 * @desc:
 */
public class UserCheckInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        User user= (User) request.getSession().getAttribute("currentUser");
        if (user==null){
            //别写死
            System.out.println("no login");
            response.sendRedirect(request.getContextPath()+"/admin/login");
            return false;
        }
        if (!user.getIsadmin()){
            System.out.println("not admin");
            response.sendRedirect(request.getContextPath()+"/admin/login");
            return false;
        }
        System.out.println("yes.........");

        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
