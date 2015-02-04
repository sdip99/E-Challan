package org.echallan.dataAccessObject;

import java.util.List;

import org.echallan.Common;
import org.echallan.valueObject.User;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

public class UserDAO extends GenericDAO {
	
	@SuppressWarnings({ "deprecation", "unchecked" })
	public User search(User vo) {
		SessionFactory factory = null;
		Session session;
		User user = null;
		try {
			factory = new Configuration().configure().buildSessionFactory();
			session = factory.openSession();
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("from User where userID = '" + vo.getUserID() + "'");
			transaction.commit();
			List<User> ret = query.list();
			if(ret != null && ret.size() > 0)
				user = ret.get(0);
			session.close();
		} catch (Exception ex) { System.err.println(ex); }
		return user;
	}
	
	public List<User> getAllUsers() {
		return getAllUsers(false);
	}
	
	@SuppressWarnings("unchecked")
	public List<User> getAllUsers(boolean withAdmin) {
		List<User> ret = null;
		Query query;
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			if(withAdmin)
				query = session.createQuery("from User");
			else
				query = session.createQuery("from User where userType=" + Common.USER_TYPE_NORMAL);
			transaction.commit();
			ret = query.list();
			session.close();
		}
		return ret;
	}
	
	public User getUser(String id) {
		User ret = null;
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("from User where userID_pkey=" + id);
			transaction.commit();
			ret = (User) query.list().get(0);
			session.close();
		}
		return ret;
	}
}
