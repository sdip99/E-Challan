package org.echallan.dataAccessObject;

import java.util.List;

import org.echallan.valueObject.Rule;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class RuleDAO extends GenericDAO {
	
	public List<Rule> getAll() {
		List<Rule> ret = null;
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("from Rule");
			transaction.commit();
			ret = query.list();
			session.close();
		}
		return ret;
}
	public Rule getRuleById(String ruleID) {
		return getRuleById(Integer.parseInt(ruleID));
	}
	public Rule getRuleById(int ruleID) {
		Session session = getSession();
		Rule rul = null;
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("from Rule where ruleId = '" + ruleID + "'");
			transaction.commit();
			List<Rule> ret = query.list();
			if(ret != null && ret.size() > 0)
				rul = ret.get(0);		
			session.close();
		}
		return rul;
	}
	public void updateRule(int catID, String newName, String newDesc, int newId, int newfine) {
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("UPDATE Rule set ruleName='" + newName + "' ruleDesc='" + newDesc + "' fine='" + newfine + "' WHERE ruleID='" + newId + "'");
			query.executeUpdate();
			transaction.commit();
			session.close();
		}
	}
	public boolean removeRule(int id) {
		return deleteById(Rule.class, id);
	}	
	
	
	
	
}