package com.hanains.webrtc.vo;

public class CounselVo {
	private String employeeId;
	private String password;
	private String name;
	
	public CounselVo(){
		
	}
	
	public CounselVo(String employeeId, String password, String name) {
		super();
		this.employeeId = employeeId;
		this.password = password;
		this.name = name;
	}
	
	public String getEmployeeId() {
		return employeeId;
	}
	public void setEmployeeId(String employeeId) {
		this.employeeId = employeeId;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return "CounselVo [employeeId=" + employeeId + ", password=" + password + ", name=" + name + "]";
	}
}
