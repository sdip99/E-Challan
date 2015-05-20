package org.echallan.valueObject;

import java.util.Date;

public class Complaint {
	private int id;
	private String email;
	private String title;
	private String description;
	private String license_no;
	private boolean acknowledged;
	private String response;
	private Date date;
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getLicense_no() {
		return license_no;
	}
	public void setLicense_no(String license_no) {
		this.license_no = license_no;
	}
	public String getResponse() {
		return response;
	}
	public void setResponse(String response) {
		this.response = response;
	}
	public boolean isAcknowledged() {
		return acknowledged;
	}
	public void setAcknowledged(boolean acknowledged) {
		this.acknowledged = acknowledged;
	}
}
