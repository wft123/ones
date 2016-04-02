package com.hanains.webrtc.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.hanains.webrtc.auth.Auth;
import com.hanains.webrtc.vo.CounselVo;

public class AuthInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		System.out.println("AuthInterceptor.PreHandler Called");
		if(handler instanceof HandlerMethod == false){
			return true;
		}
		
		Auth auth = ((HandlerMethod)handler).getMethodAnnotation(Auth.class);;
		if(auth == null){
			return true;
		}
		
		HttpSession session = request.getSession();
		if(session == null){
			response.sendRedirect(request.getContextPath()+"/counsel/");
			return false;
		}
		
		CounselVo vo = (CounselVo) session.getAttribute("authUser");
		if(vo == null){
			response.sendRedirect(request.getContextPath()+"/counsel/");
			return false;
		}
		return true;
		
	}
}

