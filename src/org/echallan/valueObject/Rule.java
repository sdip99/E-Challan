package org.echallan.valueObject;

public class Rule {
	private String ruleName;
	private String ruleDesc;
	private int ruleId;
	private int fine;
	
	private Catagory cat;
	public Catagory getCat() {
		return cat;
	}
	public void setCat(Catagory cat) {
		this.cat = cat;
	}
	public Rule(String ruleName, String ruleDesc, int ruleId, int fine) {
		// TODO Auto-generated constructor stub
		this.ruleName=ruleName;
		this.ruleDesc=ruleDesc;
		this.ruleId=ruleId;
		this.fine=fine;
		
	}
	public Rule(){}
	
	
	
	public String getRuleName() {
		return ruleName;
	}
	public void setRuleName(String ruleName) {
		this.ruleName = ruleName;
	}
	public String getRuleDesc() {
		return ruleDesc;
	}
	public void setRuleDesc(String ruleDesc) {
		this.ruleDesc = ruleDesc;
	}
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
	
	

}
