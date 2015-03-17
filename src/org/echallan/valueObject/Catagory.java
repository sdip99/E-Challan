package org.echallan.valueObject;

import java.util.Set;

public class Catagory {
	private int catID;
	private String catName;
	private String catDesc;
	private Set<Rule> rule;
	public Set<Rule> getRule() {
		return rule;
	}
	public void setRule(Set<Rule> rule) {
		this.rule = rule;
	}
	public Catagory(){ }
	public Catagory(String catName, String catDesc)
	{
		this.catName=catName;
		this.catDesc=catDesc;
		
	}
	public String getCatName() {
		return catName;
	}
	public void setCatName(String catName) {
		this.catName = catName;
	}
	public String getCatDesc() {
		return catDesc;
	}
	public void setCatDesc(String catDesc) {
		this.catDesc = catDesc;
	}
	public int getCatID() {
		return catID;
	}
	public void setCatID(int catID) {
		this.catID = catID;
	}
}
