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
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

public class CityDAO extends GenericDAO {
	public City search(City city) {
		SessionFactory factory = null;
		Session session;
		City rCity = null;
		try {
			factory = new Configuration().configure().buildSessionFactory();
			session = factory.openSession();
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
}
