package org.echallan.dataAccessObject;

import java.io.Serializable;
import java.util.List;

import org.echallan.valueObject.Catagory;
import org.echallan.valueObject.Challan;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class ChallanDAO extends GenericDAO {
	
	public List<Challan> getAll() {
		List<Challan> ret = null;
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("from Challan ");
			transaction.commit();
			ret = query.list();
			session.close();
		}
		return ret;
	}
	
	public Integer insert(Challan ch){
		Session session = getSession();
		Serializable ret;
		Transaction transaction = session.beginTransaction();
		ret = session.save(ch);
		transaction.commit();
		session.close();
		return (Integer) ret;
	}
	public Challan getChallanById(int ID) {
		Object ret = getById(Challan.class, ID);
		return (Challan) ret;
	}
}
