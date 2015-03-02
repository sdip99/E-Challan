package org.echallan.valueObject;

public class Rule {
	private String ruleName;
	private int ruleID;
	private String ruleDesc;
	private RuleCatagory ruleCatagory;
	private Fine fine;
	public String getRuleName() {
		return ruleName;
	}
	public void setRuleName(String ruleName) {
		this.ruleName = ruleName;
	}
	public int getRuleID() {
		return ruleID;
	}
	public void setRuleID(int ruleID) {
		this.ruleID = ruleID;
	}
	public String getRuleDesc() {
		return ruleDesc;
	}
	public void setRuleDesc(String ruleDesc) {
		this.ruleDesc = ruleDesc;
	}
	public RuleCatagory getRuleCatagory() {
		return ruleCatagory;
	}
	public void setRuleCatagory(RuleCatagory ruleCatagory) {
		this.ruleCatagory = ruleCatagory;
	}
	public Fine getFine() {
		return fine;
	}
	public void setFine(Fine fine) {
		this.fine = fine;
	}
}
