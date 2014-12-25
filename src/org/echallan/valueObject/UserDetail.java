package org.echallan.valueObject;

public class UserDetail {
	private String firstName;
	private String lastName;
	private String mobileNo;
	private String street;
	private String city;
	private String state;
	private int pincode;
	private int currentPosting;
	private int userID_pkey;
	private User user;
	
	public UserDetail() { }

	public UserDetail(String firstname, String lastname, int currentPosting, String mobileNo, String street, String city, String state, int pincode) {
		this.firstName = firstname;
		this.lastName = lastname;
		this.currentPosting = currentPosting;
		this.mobileNo = mobileNo;
		this.street = street;
		this.city = city;
		this.state = state;
		this.pincode = pincode;		
	}

	public int getCurrentPosting() {
		return currentPosting;
	}

	public void setCurrentPosting(int currentPosting) {
		this.currentPosting = currentPosting;
	}

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public int getPincode() {
		return pincode;
	}

	public void setPincode(int pincode) {
		this.pincode = pincode;
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
