package org.echallan.valueObject;

public class RuleDetail {
	private String catname;
	private String rulename;
	private int ruleid;
	private int fine;
	public int getFine() {
		return fine;
	}

	public void setFine(int fine) {
		this.fine = fine;
	}

	private String ruledesc;
	
	public String getCatname() {
		return catname;
	}

	public void setCatname(String catname) {
		this.catname = catname;
	}

	public String getRulename() {
		return rulename;
	}

	public void setRulename(String rulename) {
		this.rulename = rulename;
	}

	public int getRuleid() {
		return ruleid;
	}

	public void setRuleid(int ruleid) {
		this.ruleid = ruleid;
	}

	public String getRuledesc() {
		return ruledesc;
	}

	public void setRuledesc(String ruledesc) {
		this.ruledesc = ruledesc;
	}

	public RuleDetail() { }

	public RuleDetail(String catname, String rulename, int ruleid, String ruledesc, int fine) {
		this.catname = catname;
		this.rulename = rulename;
		this.ruleid= ruleid;
		this.ruledesc= ruledesc;
		this.fine= fine;
	}
	
}
