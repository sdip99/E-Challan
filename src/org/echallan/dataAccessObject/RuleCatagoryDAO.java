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
import org.echallan.valueObject.RuleCatagory;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

@SuppressWarnings("unchecked")
public class RuleCatagoryDAO extends GenericDAO {
	
	public List<RuleCatagory> getAll() {
		List<RuleCatagory> ret = null;
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("from RuleCatagory");
			transaction.commit();
			ret = query.list();
			session.close();
		}
		return ret;
	}
	
	public RuleCatagory getCatagoryById(String id) {
		Session session = getSession();
		RuleCatagory cat = null;
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("from RuleCatagory where id = '" + id + "'");
			transaction.commit();
			List<RuleCatagory> ret = query.list();
			if(ret != null && ret.size() > 0)
				cat = ret.get(0);
			session.close();
		}
		return cat;
	}
	
	public boolean removeCatagory(int id) {
		return deleteById(RuleCatagory.class, id);
	}
}
