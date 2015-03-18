package org.echallan.dataAccessObject;

import java.util.List;

import org.echallan.valueObject.Complaint;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class ComplaintDAO extends GenericDAO {
	@SuppressWarnings("unchecked")
	public List<Complaint> getAll() {
		List<Complaint> ret = null;
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("from Complaint");
			transaction.commit();
			ret = query.list();
			session.close();
		}
		return ret;
	}
	
	public Complaint getComplaintById(String id) {
		return getComplaintById(Integer.parseInt(id));
	}
	
	public Complaint getComplaintById(int id) {
		Object ret = getById(Complaint.class, id);
		return (Complaint) ret;
	}
	
	// Complaint specific delete method
	public boolean removeComplaint(int id) {
		return deleteById(Complaint.class, id);
	}
}
