package org.echallan.valueObject;

public class User {
	private int userID_pkey;
	private String userID;
	private String password;
	private int userType;
	private UserDetail userDetail;
	private String uuid;
	
	public User() { }
	
	public User(String userID, String pass, int userType) {
		this.userID = userID;
		this.password = pass;
		this.userType = userType;
	}
	
	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public void setUserID_pkey(int userID_pkey) {
		this.userID_pkey = userID_pkey;
	}

	public UserDetail getUserDetail() {
		return userDetail;
	}

	public void setUserDetail(UserDetail userDetail) {
		this.userDetail = userDetail;
	}

	public int getUserType() {
		return userType;
	}
	
	public void setUserType(int userType) {
		this.userType = userType;
	}
	
	public String getUserID() {
		return userID;
	}
	
	public void setUserID(String userID) {
		this.userID = userID;
	}
	
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	public int getUserID_pkey() {
		return userID_pkey;
	}
	
	@Override
	public String toString() {
		return userID  + " " + password + " " + userType;
	}
}
