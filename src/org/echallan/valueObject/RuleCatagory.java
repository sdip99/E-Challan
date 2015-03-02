/*******************************************************************************
 * Copyright (c) 2015 Harsh Panchal<panchal.harsh18@gmail.com>.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the GNU Public License v2.0
 * which accompanies this distribution, and is available at
 * http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
 *******************************************************************************/
package org.echallan.valueObject;

import java.util.Set;

public class RuleCatagory {
	private int id;
	private String catagoryName;
	private String catagoryDesc;
	private Set<Rule> rules;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCatagoryName() {
		return catagoryName;
	}
	public void setCatagoryName(String catagoryName) {
		this.catagoryName = catagoryName;
	}
	public String getCatagoryDesc() {
		return catagoryDesc;
	}
	public void setCatagoryDesc(String catagoryDesc) {
		this.catagoryDesc = catagoryDesc;
	}
	public Set<Rule> getRules() {
		return rules;
	}
	public void setRules(Set<Rule> rules) {
		this.rules = rules;
	}
}
