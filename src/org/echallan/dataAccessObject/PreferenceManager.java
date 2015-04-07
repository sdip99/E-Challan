package org.echallan.dataAccessObject;

import org.echallan.valueObject.Preference;

public class PreferenceManager extends GenericDAO {
	
	public Preference getPreference(String name) {
		return (Preference) getById(Preference.class, name);
	}
	
	public void updatePreference(Preference pref) {
		update(pref);
	}
}
