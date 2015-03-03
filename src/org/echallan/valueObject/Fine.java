/*******************************************************************************
 * Copyright (c) 2015 Harsh Panchal<panchal.harsh18@gmail.com>.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the GNU Public License v2.0
 * which accompanies this distribution, and is available at
 * http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
 *******************************************************************************/
package org.echallan.valueObject;

public class Fine {
	private int id;
	private double hmvAmount;
	private double lmvAmount;
	private double othrAmount = 0.0;
	private Rule rule;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public double getHmvAmount() {
		return hmvAmount;
	}
	public void setHmvAmount(float hmvAmount) {
		this.hmvAmount = hmvAmount;
	}
	public double getLmvAmount() {
		return lmvAmount;
	}
	public void setLmvAmount(float lmvAmount) {
		this.lmvAmount = lmvAmount;
	}
	public double getOthrAmount() {
		return othrAmount;
	}
	public void setOthrAmount(float othrAmount) {
		this.othrAmount = othrAmount;
	}
	public Rule getRule() {
		return rule;
	}
	public void setRule(Rule rule) {
		this.rule = rule;
	}
	@Override
	public String toString() {
		return "HMV: " + hmvAmount + "\nLMV: " + lmvAmount + "\nOthers: " + othrAmount;
	}
}
