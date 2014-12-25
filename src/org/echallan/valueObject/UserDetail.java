package org.echallan.valueObject;

public class UserDetail {
	private String firstName;
	private String lastName;
	private String mobileNo;
	private int userID_pkey;
	private User user;
	
	public UserDetail() { }

	public UserDetail(String firstname, String lastname, String mobileNo) {
		this.firstName = firstname;
		this.lastName = lastname;
		this.mobileNo = mobileNo;
	}

	public int getUserID_pkey() {
		return userID_pkey;
	}

	public void setUserID_pkey(int userID_pkey) {
		this.userID_pkey = userID_pkey;
	}
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getFirstName() {
		return firstName;
	}
	
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	
	public String getLastName() {
		return lastName;
	}
	
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	
	public String getMobileNo() {
		return mobileNo;
	}
	
	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}
	
	public int getuniqueUser_id() {
		return userID_pkey;
	}
}
