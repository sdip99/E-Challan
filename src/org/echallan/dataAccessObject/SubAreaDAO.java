/*******************************************************************************
 * Copyright (c) 2015 Harsh Panchal<panchal.harsh18@gmail.com>.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the GNU Public License v2.0
 * which accompanies this distribution, and is available at
 * http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
 *******************************************************************************/
package org.echallan.dataAccessObject;

import java.util.List;

import org.echallan.valueObject.SubArea;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

@SuppressWarnings("unchecked")
public class SubAreaDAO extends GenericDAO {
	public List<SubArea> getAll() {
		List<SubArea> ret = null;
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("from SubArea");
			transaction.commit();
			ret = query.list();
			session.close();
		}
		return ret;
	}
	
	public SubArea getSubArea(int id) {
		Object ret = getById(SubArea.class, id);
		return (SubArea) ret;
	}
	
	public void updateName(int id, String newName) {
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("UPDATE SubArea set name='" + newName + "' WHERE subarea_id='" + id + "'");
			query.executeUpdate();
			transaction.commit();
			session.close();
		}
	}
	
	// SubArea specific delete method
	public boolean removeSubArea(int id) {
		return deleteById(SubArea.class, id);
	}
}
