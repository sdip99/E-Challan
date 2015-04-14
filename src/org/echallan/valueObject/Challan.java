package org.echallan.valueObject;

import java.util.Set;

public class Challan {
	private int challan_id;
	private User user;
	private String licenseNo;
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	private String vehicleNo;
	private Set<Rules> rule;
	public Challan(String licenseNo, String vehicleNo) {
		this.licenseNo=licenseNo;
		this.vehicleNo=vehicleNo;
		
	}
	public int getChallan_id() {
		return challan_id;
	}
	public void setChallan_id(int challan_id) {
		this.challan_id = challan_id;
	}
	public String getLicenseNo() {
		return licenseNo;
	}
	public void setLicenseNo(String licenseNo) {
		this.licenseNo = licenseNo;
	}
	public String getVehicleNo() {
		return vehicleNo;
	}
	public void setVehicleNo(String vehicleNo) {
		this.vehicleNo = vehicleNo;
	}
	public Set<Rules> getRule() {
		return rule;
	}
	public void setRule(Set<Rules> rule) {
		this.rule = rule;
	}
	

}
