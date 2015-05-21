package org.echallan.dataAccessObject;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.echallan.valueObject.Challan;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

@SuppressWarnings("unchecked")
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
	
	public List<Challan> getAllByPid(int id) {
		List<Challan> ret = null;
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("from Challan where police="+id);
			transaction.commit();
			ret = query.list();
			session.close();
		}
		return ret;
	}
	
	public List<Challan> getAllByLicenseNo(String no) {
		List<Challan> ret = null;
		if(new LicenseDAO().getLicenseByNo(no) == null)
			return ret;
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("from Challan where licenseno=" + no);
			transaction.commit();
			ret = query.list();
			session.close();
		}
		return ret;
	}
	
	public List<Challan> getAllByLicenseWithinTimeSpan(int lno) {
		List<Challan> ret = null;
		Session session = getSession();
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String current = sdf.format(date);
		String start = dateFormat.format(date) + " 00:00:00";
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			System.out.println("from Challan where licenseno=" + lno + " AND timestamp between '" + start + "' AND '" + current + "'");
			Query query = session.createQuery("from Challan where licenseno=" + lno + " AND timestamp between '" + start + "' AND '" + current + "'");
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
