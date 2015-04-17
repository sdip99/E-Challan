/*******************************************************************************
 * Copyright (c) 2015 Harsh Panchal<panchal.harsh18@gmail.com>.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the GNU Public License v2.0
 * which accompanies this distribution, and is available at
 * http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
 *******************************************************************************/
package org.echallan.dataAccessObject;

import org.echallan.valueObject.UserDetail;




public class UserDetailDAO extends GenericDAO {
	
	public UserDetail getUserDetailById(int uid) {
		Object ret = getById(UserDetail.class, uid);
		return (UserDetail) ret;
	}
	
	
}
