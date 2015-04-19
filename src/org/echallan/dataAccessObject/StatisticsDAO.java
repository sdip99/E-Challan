package org.echallan.dataAccessObject;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;


@SuppressWarnings("unchecked")
public class StatisticsDAO extends GenericDAO {
	
	public int getChallanCountByUser(int uid) {
		int ret = 0;
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Calendar calendar = Calendar.getInstance();
			Query subareaList = session.createQuery("from Challan where police=" + uid + " AND YEAR(timestamp)=" + calendar.get(Calendar.YEAR) + " AND MONTH(timestamp)=" + (calendar.get(Calendar.MONTH) + 1) + " AND DAY(timestamp)=" + calendar.get(Calendar.DATE));
			ret = subareaList.list().size();
			transaction.commit();
			session.close();
		}
		return ret;
	}
	
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
	
	public int getChallanCountByCityTime(int cityid, int year) {
		int ret = 0;
		Session session = getSession();
		List<Integer> sarea = new ArrayList<Integer>();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query areaid = session.createQuery("select area_id from Area where cityid=" + cityid);
			for(Object obj : areaid.list()) {
				Query sareaids = session.createQuery("select subarea_id from SubArea where area_id=" + (Integer) obj);
				for(Object o : sareaids.list())
					sarea.add((Integer) o);
			}
			StringBuffer sb = new StringBuffer();
			for(Integer x : sarea) {
				sb.append(x + ",");
			}
			sb.deleteCharAt(sb.length() - 1);
			Query q = session.createQuery("from Challan where YEAR(timestamp)=" + year + " AND area in (" + sb.toString() + ")");
			ret = q.list().size();
			transaction.commit();
			session.close();
		}
		return ret;
	}
	
	public int getChallanCountByAreaTime(int areaid, int year) {
		int ret = 0;
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query sareaList = session.createQuery("select subarea_id from Area where area_id=" + areaid);
			StringBuffer sb = new StringBuffer();
			for(Object x : sareaList.list()) {
				sb.append(x + ",");
			}
			sb.deleteCharAt(sb.length() - 1);
			Query q = session.createQuery("from Challan where YEAR(timestamp)=" + year + " AND area in (" + sb.toString() + ")");
			ret = q.list().size();
			transaction.commit();
			session.close();
		}
		return ret;
	}
	
	public int getSuspendVehictByCityTime(int cityid, int year) {
		int ret = 0;
		Session session = getSession();
		List<Integer> sarea = new ArrayList<Integer>();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query areaid = session.createQuery("select area_id from Area where cityid=" + cityid);
			for(Object obj : areaid.list()) {
				Query sareaids = session.createQuery("select subarea_id from SubArea where area_id=" + (Integer) obj);
				for(Object o : sareaids.list())
					sarea.add((Integer) o);
			}
			StringBuffer sb = new StringBuffer();
			for(Integer x : sarea) {
				sb.append(x + ",");
			}
			sb.deleteCharAt(sb.length() - 1);
			Query q = session.createQuery("from Challan where YEAR(timestamp)=" + year + " AND issuspend='y' AND area in (" + sb.toString() + ")");
			ret = q.list().size();
			transaction.commit();
			session.close();
		}
		return ret;
	}
	
	public int getSuspendVehicByAreaTime(int areaid, int year) {
		int ret = 0;
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query sareaList = session.createQuery("select subarea_id from Area where area_id=" + areaid);
			StringBuffer sb = new StringBuffer();
			for(Object x : sareaList.list()) {
				sb.append(x + ",");
			}
			sb.deleteCharAt(sb.length() - 1);
			Query q = session.createQuery("from Challan where YEAR(timestamp)=" + year + " AND issuspend='y' AND area in (" + sb.toString() + ")");
			ret = q.list().size();
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
		if(list.size() > 0)
			return Collections.max(list);
		else
			return 0;
	}
	
	public int getMin(List<Integer> list) {
		if(list.size() > 0)
			return Collections.min(list);
		else
			return 0;
	}
	
	public int getMinYear() {
		return getMin(getDistinctYear());
	}
	
	public int getMaxYear() {
		return getMax(getDistinctYear());
	}
}
