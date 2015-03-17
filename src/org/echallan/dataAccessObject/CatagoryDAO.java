package org.echallan.dataAccessObject;

import java.util.List;

import org.echallan.valueObject.Catagory;
import org.echallan.valueObject.City;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

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
	public void updateCatagory(int catID, String newName, String newDesc) {
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("UPDATE Catagory set catName='" + newName + "' catDesc='" + newDesc + "' WHERE catID='" + catID + "'");
			
			query.executeUpdate();
			transaction.commit();
			session.close();
		}
	}
	public Catagory getCatagoryById(String cityID) {
		return getCatagoryById(Integer.parseInt(cityID));
	}
	public Catagory getCatagoryById(int catID) {
		Session session = getSession();
		Catagory cat = null;
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("from Catagory where catID = '" + catID + "'");
			transaction.commit();
			List<Catagory> ret = query.list();
			if(ret != null && ret.size() > 0)
				cat = ret.get(0);		
			session.close();
		}
		return cat;
	}
	public boolean removeCatagory(int id) {
		return deleteById(Catagory.class, id);
	}
}
