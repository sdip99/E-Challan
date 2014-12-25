package org.echallan.dataAccessObject;

import java.util.List;

import org.echallan.valueObject.User;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

public class UserDAO {
	
	@SuppressWarnings("deprecation")
	public void insert(User obj) {
		SessionFactory factory = null;
		Session session;
		try {
			factory = new Configuration().configure().buildSessionFactory();
			session = factory.openSession();
			Transaction transaction = session.beginTransaction();
			session.save(obj);
			transaction.commit();
			session.close();
		} catch (Exception ex) { System.err.println(ex); }
	}
	
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
}
