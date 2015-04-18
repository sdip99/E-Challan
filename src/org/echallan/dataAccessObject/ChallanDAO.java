package org.echallan.dataAccessObject;

import java.io.Serializable;

import org.echallan.valueObject.Catagory;
import org.echallan.valueObject.Challan;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class ChallanDAO extends GenericDAO {
	
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
