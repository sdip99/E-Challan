/*******************************************************************************
 * Copyright (c) 2015 Harsh Panchal<panchal.harsh18@gmail.com>.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the GNU Public License v2.0
 * which accompanies this distribution, and is available at
 * http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
 *******************************************************************************/
package org.echallan.dataAccessObject;

import java.util.List;

import org.echallan.valueObject.License;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class LicenseDAO extends GenericDAO {
	
	public License getLicenseByNo(String id) {
		Object ret = getById(License.class, id);
		return (License) ret;
	}
	
	public List<String> getLicenseNo(String fname, String lname, String mName, int pcode, String bgrp, String month, String date, String year) {
		List<String> ret = null;
		Session session = getSession();
		if(session != null) {
			Transaction transaction = session.beginTransaction();
			Query query = session.createQuery("select lincenNo from License where fName='" + fname + "' and lName='" + lname + "' and mName='" + mName + "' and pincode=" + pcode + " and bGroup='" + bgrp + "' and birthDate like '" + year + "-" + month + "-" + date + "'");
			transaction.commit();
			ret = query.list();
			session.close();
		}
		return ret;
	}
}
