/*******************************************************************************
 * Copyright (c) 2015 Harsh Panchal<panchal.harsh18@gmail.com>.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the GNU Public License v2.0
 * which accompanies this distribution, and is available at
 * http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
 *******************************************************************************/
package org.echallan.valueObject;

public class SubArea {
	private int subarea_id;
	private String name;
	private Area area;
	
	public int getSubarea_id() {
		return subarea_id;
	}
	public void setSubarea_id(int subarea_id) {
		this.subarea_id = subarea_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Area getArea() {
		return area;
	}
	public void setArea(Area area) {
		this.area = area;
	}
}
