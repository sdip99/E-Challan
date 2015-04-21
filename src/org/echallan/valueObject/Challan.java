package org.echallan.valueObject;

import java.util.Date;
import java.util.Set;

public class Challan {
	private int challan_id;
	private String licenseNo;
	private Date timestamp;
	private String vehicleNo;
	private boolean issuspend;
	private User police;
	private SubArea area;
	private String fname;
	private String lname;
	
	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}

	public String getLname() {
		return lname;
	}

	public void setLname(String lname) {
		this.lname = lname;
	}

	public SubArea getArea() {
		return area;
	}

	public void setArea(SubArea area) {
		this.area = area;
	}

	public boolean isIssuspend() {
		return issuspend;
	}

	public void setIssuspend(boolean issuspend) {
		this.issuspend = issuspend;
	}

	private Set<Rule> rule;
	
	
	public Challan() {}
	
	public Challan(String licenseNo, String vehicleNo) {
		this.licenseNo=licenseNo;
		this.vehicleNo=vehicleNo;
		
	}
	
	public Date getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(Date timestamp) {
		this.timestamp = timestamp;
	}

	public User getPolice() {
		return police;
	}

	public void setPolice(User police) {
		this.police = police;
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

	public Set<Rule> getRule() {
		return rule;
	}

	public void setRule(Set<Rule> rule) {
		this.rule = rule;
	}
	
	
	
}
