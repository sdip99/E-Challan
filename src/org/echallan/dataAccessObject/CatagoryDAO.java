package org.echallan.dataAccessObject;

import java.util.List;

import org.echallan.valueObject.Catagory;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

@SuppressWarnings("unchecked")
public class CatagoryDAO extends GenericDAO {
		
	public List<Catagory> getAll() {
		List<Catagory> ret = null;
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("from Catagory");
			transaction.commit();
			ret = query.list();
			session.close();
		}
		return ret;
	}
	
	public Catagory getCatagoryById(String catID) {
		Object ret = getById(Catagory.class, Integer.parseInt(catID));
		return (Catagory) ret;
	}
	
	public Catagory getCatagoryById(int catID) {
		Object ret = getById(Catagory.class, catID);
		return (Catagory) ret;
	}
	
	public boolean removeCatagory(int id) {
		return deleteById(Catagory.class, id);
	}
}
