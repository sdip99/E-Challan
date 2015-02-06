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
	
	public Area getAreaById(int areaID) {
		Session session = getSession();
		Area area = null;
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("from Area where area_id = '" + areaID + "'");
			transaction.commit();
			List<Area> ret = query.list();
			if(ret != null && ret.size() > 0)
				area = ret.get(0);		// Area name has unique constraint so there must be only one result
			session.close();
		}
		return area;
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
	
	// Area specific delete method
	public boolean removeArea(int id) {
		return deleteById(Area.class, id);
	}
}
