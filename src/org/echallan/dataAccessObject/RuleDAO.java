package org.echallan.dataAccessObject;

import java.util.List;

import org.echallan.valueObject.Rule;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

@SuppressWarnings("unchecked")
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
	
	public List<Rule> getAllByCatagory(int catagory) {
		List<Rule> ret = null;
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("from Rule where catid=" + catagory);
			transaction.commit();
			ret = query.list();
			session.close();
		}
		return ret;
	}
	
	public List<Rule> getAllFiltered(List<Integer> filtered, int catagory) {
		List<Rule> ret = null;
		if(filtered.size() == 0)
			return getAllByCatagory(catagory);
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			StringBuffer sb = new StringBuffer("from Rule where catid=" + catagory + " AND rule_id not in (");
			for(int x : filtered)
				sb.append(x + ",");
			sb.deleteCharAt(sb.length() - 1);
			sb.append(")");
			Query query = session.createQuery(sb.toString());
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