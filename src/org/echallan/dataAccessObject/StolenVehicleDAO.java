package org.echallan.dataAccessObject;

import org.echallan.valueObject.StolenVehicle;

public class StolenVehicleDAO extends GenericDAO {
	
	public boolean isStolenVehicle(String vehicleNo) {
		return getStlnVehicleById(vehicleNo) == null ? false : true;
	}
	
	public StolenVehicle getStlnVehicleById(String id) {
		StolenVehicle vehicle = null;
		Object object = getById(StolenVehicle.class, id);
		if(object != null)
			vehicle = (StolenVehicle) object;
		return vehicle;
	}
	
	public boolean removeStlnVehic(String id) {
		return deleteById(StolenVehicle.class, id);
	}
}
