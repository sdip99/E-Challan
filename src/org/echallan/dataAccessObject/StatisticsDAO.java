package org.echallan.dataAccessObject;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;

@SuppressWarnings("unchecked")
public class StatisticsDAO extends GenericDAO {
	
	public int getIncomeByYear(int year) {
		int ret = 0;
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("select challan_id from Challan where YEAR(timestamp)=" + year);
			for(Object s : query.list()) {
				SQLQuery q = session.createSQLQuery("select rule_id from chln_rule where challan_id=" + s);
				for(Object x : q.list()) {
					SQLQuery d = session.createSQLQuery("select fine from rule where rule_id=" + x);
					ret += (Integer) d.list().get(0);
				}
			}
			transaction.commit();
			session.close();
		}
		return ret;
	}
	
	public int getChallanCountForYear(int year) {
		int ret = 0;
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("from Challan where YEAR(timestamp)=" + year);
			transaction.commit();
			ret = query.list().size();
			session.close();
		}
		return ret;
	}
	
	public int getComplaintCountForYear(int year) {
		int ret = 0;
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("from Complaint where YEAR(date)=" + year);
			transaction.commit();
			ret = query.list().size();
			session.close();
		}
		return ret;
	}
	
	public int getVehicleSusCountForYear(int year) {
		int ret = 0;
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("from Challan where issuspend='y' AND YEAR(timestamp)=" + year);
			transaction.commit();
			ret = query.list().size();
			session.close();
		}
		return ret;
	}
	
	public List<Integer> getDistinctYear() {
		List<Integer> ret = new ArrayList<Integer>();
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("select distinct EXTRACT(YEAR FROM timestamp) from Challan");
			transaction.commit();
			ret = query.list();
			session.close();
		}
		return ret;
	}
	
	public int getMax(List<Integer> list) {
		int max = 0;
		for(Integer x : list) {
			if(x > max)
				max = x;
		}
		return max;
	}
	
	public int getMin(List<Integer> list) {
		int min = 0;
		for(Integer x : list) {
			if(x < min)
				min = x;
		}
		return min;
	}
	
	public int getMinYear() {
		return getMin(getDistinctYear());
	}
	
	public int getMaxYear() {
		return getMax(getDistinctYear());
	}
}
