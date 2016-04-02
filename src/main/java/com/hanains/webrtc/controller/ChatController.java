package com.hanains.webrtc.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/chat")
public class ChatController {

	@RequestMapping("/")
	public String chat(Model model, @RequestParam(value = "name", required = true, defaultValue = "") String name,
			@RequestParam(value = "key", required = true, defaultValue = "") String key) {
		// try {
		// InetAddress ip = InetAddress.getLocalHost();
		// model.addAttribute("ip", ip.getHostAddress());
		// } catch (UnknownHostException e) {
		// e.printStackTrace();
		// }
		model.addAttribute("ip", "121.138.83.100");
		model.addAttribute("name", name.trim());
		model.addAttribute("key", key.trim());
		return "/client/chat";
	}

	@RequestMapping("/waiting")
	public String waiting(Model model, @RequestParam(value = "name", required = true, defaultValue = "") String name,
			@RequestParam(value = "key", required = true, defaultValue = "") String key) {
		// try {
		// InetAddress ip = InetAddress.getLocalHost();
		// model.addAttribute("ip", ip.getHostAddress());
		// } catch (UnknownHostException e) {
		// e.printStackTrace();
		// }
		model.addAttribute("ip", "121.138.83.100");

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREA);
		Date currentTime = new Date();
		String dTime = formatter.format(currentTime);

		model.addAttribute("name", name);
		model.addAttribute("key", key.trim());
		model.addAttribute("time", dTime.trim());
		return "/client/waiting";
	}

}
