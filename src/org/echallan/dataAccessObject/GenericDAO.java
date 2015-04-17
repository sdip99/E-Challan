package org.echallan.dataAccessObject;

import java.io.Serializable;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

@SuppressWarnings("deprecation")
public class GenericDAO {
	
	static SessionFactory factory = null;
	
	public Session getSession() {
		Session session = null;
		if(factory == null) {
			try {
				factory = new Configuration().configure().buildSessionFactory();
			} catch (Exception ex) { System.err.println(ex); }
		}
		session = factory.openSession();
		return session;
	}
	
	public void insert(Object obj) {
		Session session = getSession();
		Transaction transaction = session.beginTransaction();
		session.save(obj);
		transaction.commit();
		session.close();
	}
	
	public Object getById(Class<?> clazz, Serializable id) {
		Session session = getSession();
		Object obj = session.get(clazz, id);
		session.close();
		return obj;
	}
	
	public void update(Object obj) {
		Session session = getSession();
		Transaction transaction = session.beginTransaction();
		session.update(obj);
		transaction.commit();
		session.close();
	}
	
	/**
	 * Removes persistent instance of class from database as
	 * transient instance fails to remove due to foreign key constraint 
	 */
	public boolean deleteById(Class<?> clazz, int id) {
		Session session = getSession();
		Transaction transaction = session.beginTransaction();
		Serializable pk = new Integer(id);
		Object pInstance = session.get(clazz, pk);
		if(pInstance != null) {
			session.delete(pInstance);
			transaction.commit();
			return true;
		}
		session.close();
		return false;
	}
	
	public boolean deleteById(Class<?> clazz, String id) {
		Session session = getSession();
		Transaction transaction = session.beginTransaction();
		Serializable pk = new String(id);
		Object pInstance = session.load(clazz, pk);
		if(pInstance != null) {
			session.delete(pInstance);
			transaction.commit();
			return true;
		}
		session.close();
		return false;
	}
}
