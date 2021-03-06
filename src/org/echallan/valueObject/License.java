
package org.echallan.valueObject;

import java.util.Date;


public class License {
	private String lincenNo;
	private String fName;
	private String lName;
	private String mName;
	private Date birthDate;
	private int pincode;
	private String address;
	public String getAddress() {
		return address;
	}
	private String imgURL;
	private String bGroup;
	public String getLincenNo() {
		return lincenNo;
	}
	public void setLincenNo(String lincenNo) {
		this.lincenNo = lincenNo;
	}
	public String getfName() {
		return fName;
	}
	public void setfName(String fName) {
		this.fName = fName;
	}
	public String getlName() {
		return lName;
	}
	public void setlName(String lName) {
		this.lName = lName;
	}
	public String getmName() {
		return mName;
	}
	public void setmName(String mName) {
		this.mName = mName;
	}
	public Date getBirthDate() {
		return birthDate;
	}
	public void setBirthDate(Date birthDate) {
		this.birthDate = birthDate;
	}
	public int getPincode() {
		return pincode;
	}
	public void setPincode(int pincode) {
		this.pincode = pincode;
	}
	public String getImgURL() {
		return imgURL;
	}
	public void setImgURL(String imgURL) {
		this.imgURL = imgURL;
	}
	public String getbGroup() {
		return bGroup;
	}
	public void setbGroup(String bGroup) {
		this.bGroup = bGroup;
	}
}
