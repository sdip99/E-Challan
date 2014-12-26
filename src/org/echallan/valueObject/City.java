/*******************************************************************************
 * Copyright (c) 2014 Harsh Panchal<panchal.harsh18@gmail.com>.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the GNU Public License v2.0
 * which accompanies this distribution, and is available at
 * http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
 *******************************************************************************/
package org.echallan.valueObject;

public class City {
	private int cityID;
	private String name;
	
	// For hibernate
	public City() { }
	
	public City(String name) {
		this.name = name;
	}
	
	public int getCityID() {
		return cityID;
	}
	
	public void setCityID(int cityID) {
		this.cityID = cityID;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
}
