package org.echallan.dataAccessObject;

import java.util.List;

import org.echallan.valueObject.Rule;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class RuleDAO extends GenericDAO {
	
	@SuppressWarnings("unchecked")
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
	
	public Rule getRuleById(int ruleID) {
		Object ret = getById(Rule.class, ruleID);
		return (Rule) ret;
	}
	
	public boolean removeRule(int id) {
		return deleteById(Rule.class, id);
	}	
	
	
	
	
}