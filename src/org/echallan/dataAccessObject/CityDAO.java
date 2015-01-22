/*******************************************************************************
 * Copyright (c) 2014 Harsh Panchal<panchal.harsh18@gmail.com>.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the GNU Public License v2.0
 * which accompanies this distribution, and is available at
 * http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
 *******************************************************************************/
package org.echallan.dataAccessObject;

import java.util.List;

import org.echallan.valueObject.City;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

@SuppressWarnings("unchecked")
public class CityDAO extends GenericDAO {
	
	public City search(City city) {
		Session session = getSession();
		if(session == null)
			return null;
		City rCity = null;
		try {
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("from City where name = '" + city.getName() + "'");
			transaction.commit();
			List<City> ret = query.list();
			if(ret != null && ret.size() > 0)
				rCity = ret.get(0);		// City name has unique constraint so there must be only one result
			session.close();
		} catch (Exception ex) { System.err.println(ex); }
		return rCity;
	}
	
	public List<City> getAll() {
		List<City> ret = null;
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("from City");
			transaction.commit();
			ret = query.list();
			session.close();
		}
		return ret;
	}
}
