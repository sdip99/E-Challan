/*******************************************************************************
 * Copyright (c) 2014 Harsh Panchal<panchal.harsh18@gmail.com>.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the GNU Public License v2.0
 * which accompanies this distribution, and is available at
 * http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
 *******************************************************************************/
package org.echallan.dataAccessObject;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

@SuppressWarnings("deprecation")
public class GenericDAO {
	
	public Session getSession() {
		SessionFactory factory = null;
		Session session = null;
		try {
			factory = new Configuration().configure().buildSessionFactory();
			session = factory.openSession();
		} catch (Exception ex) { System.err.println(ex); }
		return session;
	}
	
	public void insert(Object obj) {
		Session session = getSession();
		Transaction transaction = session.beginTransaction();
		session.save(obj);
		transaction.commit();
		session.close();
	}
}
