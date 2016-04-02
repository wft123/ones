package com.hanains.webrtc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hanains.webrtc.auth.Auth;
import com.hanains.webrtc.vo.CounselVo;

@Controller
@RequestMapping("/counsel")
public class CounselController {

	@RequestMapping("/")
	public String index(Model model) {
		return "/counsel/index";
	}

	@Auth
	@RequestMapping("/lobby")
	public String lobby(Model model) {
		// try {
		// InetAddress ip = InetAddress.getLocalHost();
		// model.addAttribute("ip", ip.getHostAddress());
		// } catch (UnknownHostException e) {
		// e.printStackTrace();
		// }
		model.addAttribute("ip", "121.138.83.100");
		return "/counsel/lobby";
	}

	@Auth
	@RequestMapping("/chat")
	public String chat(Model model, @RequestParam(value = "name", required = true, defaultValue = "") String name,
			@RequestParam(value = "key", required = true, defaultValue = "") String key) {
		// try {
		// InetAddress ip = InetAddress.getLocalHost();
		// model.addAttribute("ip", ip.getHostAddress());
		// } catch (UnknownHostException e) {
		// e.printStackTrace();
		// }
		model.addAttribute("ip", "121.138.83.100");

		model.addAttribute("name", name);
		model.addAttribute("key", key.trim());
		return "/counsel/chat";
	}
	
	@RequestMapping("/login")
	public String login(){
		return "/counsel/loginform";
	}
	
	@RequestMapping("/loginSuccess")
	public String loginSuccess(@RequestParam(value="employeeId", required=true, defaultValue="") String employeeId,
	@RequestParam(value="password", required=true, defaultValue="") String password,	@ModelAttribute CounselVo vo){
		if((employeeId.equals(vo.getEmployeeId())) && (password.equals(vo.getPassword()))){
			return "/counsel/index";
		}
		return "/counsel/loginform";
	}

	public CounselVo authLogin(CounselVo vo){
		CounselVo authUser = vo;
		return authUser;
	}
	
	@RequestMapping("/loginretry")
	public String loginRetry(){
		return "/counsel/loginform";
	}

}
