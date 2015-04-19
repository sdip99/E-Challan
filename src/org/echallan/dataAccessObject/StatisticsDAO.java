package org.echallan.dataAccessObject;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;


@SuppressWarnings("unchecked")
public class StatisticsDAO extends GenericDAO {
	
	public int getChallanCountBySubArea(int id) {
		int ret = 0;
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query subareaList = session.createQuery("select challan_id from Challan where area=" + id);
			ret = subareaList.list().size();
			transaction.commit();
			session.close();
		}
		return ret;
	}
	
	public int getChallanCountByArea(int areaid) {
		int ret = 0;
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			//SQLQuery areaList = session.createSQLQuery("select subarea_id from subarea where area_id=" + areaid);
			Query areaList = session.createQuery("select subarea_id from SubArea where area_id=" + areaid);
			for(Object obj : areaList.list()) {
				ret += session.createQuery("select challan_id from Challan where area=" + (Integer) obj).list().size();
			}
			transaction.commit();
			session.close();
		}
		return ret;
	}
	
	public int getChallanCountByCity(int cityid) {
		int ret = 0;
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query areaList = session.createQuery("select area_id from Area where cityid=" + cityid);
			for(Object obj : areaList.list())
				ret += getChallanCountByArea((Integer) obj);
			transaction.commit();
			session.close();
		}
		return ret;
	}
	
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
		return Collections.max(list);
	}
	
	public int getMin(List<Integer> list) {
		return Collections.min(list);
	}
	
	public int getMinYear() {
		return getMin(getDistinctYear());
	}
	
	public int getMaxYear() {
		return getMax(getDistinctYear());
	}
}
