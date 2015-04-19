package org.echallan.dataAccessObject;

import java.util.List;

import org.echallan.Common;
import org.echallan.valueObject.User;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class UserDAO extends GenericDAO {
	
	public User getUserById(int id) {
		Object ret = getById(User.class, id);
		return (User) ret;
	}
	
	public User getUserById(String id) {
		return getUserById(Integer.parseInt(id));
	}
	
	public List<User> getAllUsers() {
		return getAllUsers(false);
	}
	
	@SuppressWarnings("rawtypes")
	public User getByUserId(String id) {
		User ret = null;
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("from User where userID='" + id + "'");
			transaction.commit();
			List tmp = query.list();
			if(tmp.size() > 0)
				ret = (User) tmp.get(0);
			session.close();
		}
		return ret;
	}
	
	public void updatePass(String uid, String newPass) {
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("UPDATE User set password='" + newPass + "' WHERE userID='" + uid + "'");
			query.executeUpdate();
			transaction.commit();
			session.close();
		}
	}
	
	public void updateuid(String uid, String newuid) {
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("UPDATE User set userID='" + newuid + "' WHERE userID='" + uid + "'");
			query.executeUpdate();
			transaction.commit();
			session.close();
		}
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
		Object ret = getById(User.class, Integer.parseInt(id));
		return (User) ret;
	}
	
	public User getUser(int id) {
		Object ret = getById(User.class, id);
		return (User) ret;
	}
}
