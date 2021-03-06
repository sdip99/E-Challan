/*******************************************************************************
 * Copyright (c) 2015 Harsh Panchal<panchal.harsh18@gmail.com>.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the GNU Public License v2.0
 * which accompanies this distribution, and is available at
 * http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
 *******************************************************************************/
package org.echallan.dataAccessObject;

import java.util.List;

import org.echallan.valueObject.Area;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

@SuppressWarnings("unchecked")
public class AreaDAO extends GenericDAO {
	
	public Area getAreaById(String areaID) {
		return getAreaById(Integer.parseInt(areaID));
	}
	
	public Area getAreaById(int areaID) {
		Object ret = getById(Area.class, areaID);
		return (Area) ret;
	}
	
	public List<Area> getAll() {
		List<Area> ret = null;
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("from Area");
			transaction.commit();
			ret = query.list();
			session.close();
		}
		return ret;
	}
	
	public void updateName(int areaID, String newName) {
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("UPDATE Area set name='" + newName + "' WHERE area_id='" + areaID + "'");
			query.executeUpdate();
			transaction.commit();
			session.close();
		}
	}
	
	// Area specific delete method
	public boolean removeArea(int id) {
		return deleteById(Area.class, id);
	}
}
