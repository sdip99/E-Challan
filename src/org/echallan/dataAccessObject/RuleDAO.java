package org.echallan.dataAccessObject;

import java.util.List;

import org.echallan.valueObject.Rule;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

public class RuleDAO{

	@SuppressWarnings("deprecation")
	public Session getSession() {
		SessionFactory factory = null;
		Session session = null;
		try {
			factory = new Configuration().configure().buildSessionFactory();
			session = factory.openSession();
		} catch (Exception ex) { System.err.println(ex); }
		return session;
	}
	
	public void insert(Object obj) {
		Session session = getSession();
		Transaction transaction = session.beginTransaction();
		session.save(obj);
		transaction.commit();
		session.close();
	}
	

	@SuppressWarnings("unchecked")
	public List<Rule> getAll() {
		List<Rule> ret = null;
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("from RuleDetail");
			transaction.commit();
			ret = query.list();
			session.close();
		}
		return ret;
	}
	@SuppressWarnings("unchecked")
	public Rule getRuleById(int Ruleid) {
		Session session = getSession();
		Rule rule = null;
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("from RuleDetail where ruleid = '" + Ruleid + "'");
			transaction.commit();
			List<Rule> ret = query.list();
			if(ret != null && ret.size() > 0)
				rule = ret.get(0);		
			session.close();
		}
		return rule;
	}
	public void removeRule(int Ruleid) {
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("DELETE from RuleDetail WHERE Ruleid='" + Ruleid + "'");
			query.executeUpdate();
			transaction.commit();
			session.close();
		}
	}
	
	public void updateRule(int ruleid, String newName, int fine) {
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("UPDATE RuleDetail set rulename='" + newName + "', fine='" + fine + "' WHERE ruleid='" + ruleid + "'");
			query.executeUpdate();
			transaction.commit();
			session.close();
		}
	}
}
