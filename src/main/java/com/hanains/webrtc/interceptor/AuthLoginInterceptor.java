package com.hanains.webrtc.interceptor;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.hanains.webrtc.controller.CounselController;
import com.hanains.webrtc.vo.CounselVo;
import com.hanains.webrtc.xmlparser.DomParser;

public class AuthLoginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		System.out.println("AuthLoginInterceptor.PreHandle Called");
		String employeeId = request.getParameter("employeeId");
		String password = request.getParameter("password");
		System.out.println(employeeId);
		System.out.println(password);
		
		File file = new File("C:\\hana\\workspace\\ones\\EmployeeDB.xml");
		DomParser domParser = new DomParser(file);
		List<CounselVo> result = domParser.parse("data");
		CounselVo vo = new CounselVo();
		ApplicationContext applicationContext = WebApplicationContextUtils.getWebApplicationContext(request.getServletContext());
		CounselController counselController = applicationContext.getBean(CounselController.class);
		
		if((employeeId.trim().length() == 0)||(password.trim().length() == 0)){
			response.sendRedirect(request.getContextPath()+"/counsel/loginretry");
			return false;
		}
	
		for(int i=0; i<result.size(); i++){			
			
			if((employeeId.equals(result.get(i).getEmployeeId())) && ((password.equals(result.get(i).getPassword())))){
				vo.setEmployeeId(result.get(i).getEmployeeId());
				vo.setPassword(result.get(i).getPassword());
				vo.setName(result.get(i).getName());
				CounselVo authUser = counselController.authLogin(vo);
				
				if(authUser == null){
					response.sendRedirect(request.getContextPath()+"/counsel/loginretry");
					return false;
				}
				
				//login ó��
				HttpSession session = request.getSession(true);
				session.setAttribute("authUser", authUser);
				System.out.println(authUser);
				response.sendRedirect(request.getContextPath()+"/counsel/");
				return false;
			}
		}
		response.sendRedirect(request.getContextPath()+"/counsel/loginretry");
		return true;
	}
}

