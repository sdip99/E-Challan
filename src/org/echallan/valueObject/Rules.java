package org.echallan.valueObject;

public class Rules {
	public int getRuleId() {
		return ruleId;
	}
	public void setRuleId(int ruleId) {
		this.ruleId = ruleId;
	}
	public int getFine() {
		return fine;
	}
	public void setFine(int fine) {
		this.fine = fine;
	}
	public Challan getChallan() {
		return challan;
	}
	public void setChallan(Challan challan) {
		this.challan = challan;
	}
	private int ruleId;
	private int fine;
	private Challan challan;

}
