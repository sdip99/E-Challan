package org.echallan.controller;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.echallan.Common;
import org.echallan.dataAccessObject.AreaDAO;
import org.echallan.dataAccessObject.CatagoryDAO;
import org.echallan.dataAccessObject.ChallanDAO;
import org.echallan.dataAccessObject.CityDAO;
import org.echallan.dataAccessObject.ComplaintDAO;
import org.echallan.dataAccessObject.LicenseDAO;
import org.echallan.dataAccessObject.PreferenceManager;
import org.echallan.dataAccessObject.RuleDAO;
import org.echallan.dataAccessObject.SubAreaDAO;
import org.echallan.dataAccessObject.UserDAO;
import org.echallan.dataAccessObject.UserDetailDAO;
import org.echallan.valueObject.Area;
import org.echallan.valueObject.Catagory;
import org.echallan.valueObject.Challan;
import org.echallan.valueObject.City;
import org.echallan.valueObject.Complaint;
import org.echallan.valueObject.License;
import org.echallan.valueObject.Preference;
import org.echallan.valueObject.Rule;
import org.echallan.valueObject.SubArea;
import org.echallan.valueObject.User;
import org.echallan.valueObject.UserDetail;

/**
 * Servlet implementation class Controller
 */
@WebServlet("/Controller")
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Controller() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	if(request.getParameter("cat_id") != null) {
    		CatagoryDAO dao = new CatagoryDAO();
    		PrintWriter writer = response.getWriter();
    		Set<Rule> rules = dao.getCatagoryById(request.getParameter("cat_id")).getRule();
    		writer.write("<select  class='form-control inline-ele-left' style='width: 25%; margin-left: 6px;' name='rule_drop'>");
    		for(Rule r : rules)
    			writer.write("<option value=" + r.getRuleId()+ " >" + r.getRuleName() + "</option>");
    		writer.write("</select>");
    		
    		writer.close();
    	} else if(request.getParameter("mng_chk_city_id") != null) {
    		PrintWriter writer = response.getWriter();
    		writer.write("<select class='form-control inline-ele-left' name='area_drop' style='width: 25%;'>");
    		Integer id = null;
    		try {
    			id = Integer.parseInt(request.getParameter("mng_chk_city_id"));
    		} catch(Exception ex) {
    			writer.write("</select>");
    			writer.close();
    			return;
    		}
    		Set<Area> areas = new CityDAO().getCityById(id).getArea();
    		for(Area a : areas)
    			writer.write("<option value='" + a.getArea_id() + "'>" + a.getName() + "</option>");
    		writer.write("</select>");
    	} else if(request.getParameter("city_id") != null) {
    		PrintWriter writer = response.getWriter();
    		writer.write("<select class=\"form-control\" name=\"area_assigned\" id=\"area_assigned\" onChange=\"return sendInfo('area');\">'");
    		Set<Area> areas = new CityDAO().getCityById(request.getParameter("city_id")).getArea();
    		for(Area a : areas)
    			writer.write("<option value='" + a.getArea_id() + "'>" + a.getName() + "</option>");
    		writer.write("</select>");
    	} else if(request.getParameter("area_id") != null) {
    		PrintWriter writer = response.getWriter();
    		writer.write("<select class='form-control' name='subarea_assigned' id='subarea_drop'>");
    		Set<SubArea> sareas = new AreaDAO().getAreaById(request.getParameter("area_id")).getSubarea();
    		for(SubArea s : sareas)
    			writer.write("<option value='" + s.getSubarea_id() + "'>" + s.getName() + "</option>");
    		writer.write("</select>");
    	}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getParameter("submit").equals("Sign In")) {
			HttpSession session = request.getSession();
			String pass = request.getParameter("password");
			User vo = new User();
			vo.setUserID(request.getParameter("username"));
			vo.setPassword(pass);
			UserDAO dao = new UserDAO();
			vo = dao.search(vo);
		if(vo == null) {
				// Username doesn't exist, don't match password just redirect 
				session.setAttribute("invalidLogin", true);
				response.sendRedirect("login.jsp");
				return;
		} else {
				if(pass.equals(vo.getPassword())) {
					// Everything ok send to homepage & store user info into session
					session.setAttribute("user_info", vo);
					if(vo.getUserType() == Common.USER_TYPE_NORMAL) {
						// user is an officer so load his addition information also
						response.sendRedirect("police_dashboard.jsp");
					} else {
						response.sendRedirect("admin_dashboard.jsp");
					}
				} else {
					// password doesn't match
					session.setAttribute("invalidLogin", true);
					response.sendRedirect("login.jsp");
				}
			}
		
		} else if(request.getParameter("submit").equals("Insert Officer")) {
			HttpSession session = request.getSession();
			session.setAttribute("add_officer_status", true);
			String fname = request.getParameter("first_name");
			String lname = request.getParameter("last_name");
			String mobileNo = request.getParameter("mobile_no");
			String street = request.getParameter("street");
			String state = request.getParameter("state");
			String city = request.getParameter("city");
			String email = request.getParameter("email");
			String pass = request.getParameter("password");
			if(fname != null && !fname.equals("") &&
					lname != null && !lname.equals("") &&
					mobileNo != null && !mobileNo.equals("") &&
					street != null && !street.equals("") &&
					state != null && !state.equals("") &&
					city != null && !city.equals("") &&
					email != null && !email.equals("") &&
					pass != null && !pass.equals("")) {
				try {
					int pincode = Integer.parseInt(request.getParameter("pincode"));
					int subAreaAssign = Integer.parseInt(request.getParameter("subarea_assigned"));
					UserDetail userDetail = new UserDetail(fname, lname, subAreaAssign, mobileNo, street, city, state, pincode);
					User user = new User(email, pass, 0);
					user.setUserDetail(userDetail);
					userDetail.setUser(user);
					UserDAO dao = new UserDAO();
					dao.insert(user);
				} catch(NumberFormatException ex) {
					session.setAttribute("add_officer_status", false);
				}
			} else session.setAttribute("add_officer_status", false);
			response.sendRedirect("add_officer.jsp");
		
		} else if(request.getParameter("submit").equals("Insert City")) {
			HttpSession session = request.getSession();
			String name = request.getParameter("city_name");
			if(name != null && !name.equals("")) {
				City city = new City(name);
				CityDAO dao = new CityDAO();
				dao.insert(city);
				session.setAttribute("city_update_status", true);
			} else session.setAttribute("city_update_status", false);
			response.sendRedirect("insert_city.jsp");
			
		} else if(request.getParameter("submit").equals("Insert Area")) {
			HttpSession session = request.getSession();
			session.setAttribute("area_insert_status", true);
			String name = request.getParameter("area_name");
			if(name != null && !name.equals("")) {
				try {
					int cityID = Integer.parseInt(request.getParameter("subarea_drop"));
					City city = new CityDAO().getCityById(cityID);
					Area area = new Area();
					area.setName(name);
					area.setCity(city);
					city.getArea().add(area);
					new AreaDAO().insert(area);
				} catch(NumberFormatException ex) {
					session.setAttribute("area_insert_status", false);
				}
			} else session.setAttribute("area_insert_status", false);
			response.sendRedirect("insert_area.jsp");
		
		} else if(request.getParameter("submit").equals("Insert CheckPost")) {
			HttpSession session = request.getSession();
			session.setAttribute("insert_chkpost_status", true);
			String name = request.getParameter("subarea_name");
			if(name != null && !name.equals("")) {
				try {
					int areaID = Integer.parseInt(request.getParameter("area_drop"));
					Area area = new AreaDAO().getAreaById(areaID);
					SubArea subArea = new SubArea();
					subArea.setName(name);
					subArea.setArea(area);
					SubAreaDAO dao = new SubAreaDAO();
					dao.insert(subArea);
				} catch(NumberFormatException ex) {
					session.setAttribute("insert_chkpost_status", false);
				}
			} else session.setAttribute("insert_chkpost_status", false);
			response.sendRedirect("insert_checkpost.jsp");
		
		} else if(request.getParameter("submit").equals("Update City")) {
			HttpSession session = request.getSession();
			String name = request.getParameter("city_name");
			session.setAttribute("upd_city", true);
			if(name != null && !name.equals("")) {
				int id = Integer.parseInt((String) session.getAttribute("city_id"));
				new CityDAO().updateCity(id, name);
			} else session.setAttribute("upd_city", false);
			response.sendRedirect("manage_city.jsp");
		
		} else if(request.getParameter("submit").equals("Update Officer")) {
			HttpSession session = request.getSession();
			session.setAttribute("upd_off_status", true);
			
			String uid = (String) session.getAttribute("uid");
			String fname = request.getParameter("first_name");
			String lname = request.getParameter("last_name");
			String mobileNo = request.getParameter("mobile_no");
			String street = request.getParameter("street");
			String state = request.getParameter("state");
			String city = request.getParameter("city");
			String email = request.getParameter("email");
			String pass = request.getParameter("password");
			if(uid != null && !uid.equals("") &&
					fname != null && !fname.equals("") &&
					lname != null && !lname.equals("") &&
					mobileNo != null && !mobileNo.equals("") &&
					street != null && !street.equals("") &&
					state != null && !state.equals("") &&
					city != null && !city.equals("") &&
					email != null && !email.equals("") &&
					pass != null && !pass.equals("")) {
				try {
					int pincode = Integer.parseInt(request.getParameter("pincode"));
					int subAreaAssign = Integer.parseInt(request.getParameter("subarea_assigned"));
					User oldUser = new UserDAO().getUser(uid);
					User user = new User(email, pass, Common.USER_TYPE_NORMAL);
					user.setUserID_pkey(Integer.parseInt(uid));
					if(pass != null && pass == "")
						user.setPassword(oldUser.getPassword());
					new UserDAO().update(user);
					UserDetail uDetail = oldUser.getUserDetail();
					uDetail.setCity(city);
					uDetail.setCurrentPosting(subAreaAssign);
					uDetail.setFirstName(fname);
					uDetail.setLastName(lname);
					uDetail.setMobileNo(mobileNo);
					uDetail.setPincode(pincode);
					uDetail.setState(state);
					uDetail.setStreet(street);
					new UserDetailDAO().update(uDetail);
				} catch(NumberFormatException ex) {
					session.setAttribute("upd_off_status", false);
				}
			} else session.setAttribute("upd_off_status", false);
			// TODO: Redirect back to same page
			response.sendRedirect("manage_officer.jsp");
		
		} else if(request.getParameter("submit").equals("Update Area")) {
			HttpSession session = request.getSession();
			session.setAttribute("upd_area", true);
			String newName = request.getParameter("area_name");
			if(newName != null && !newName.equals("")) {
				try {
					int id = Integer.parseInt((String) session.getAttribute("area_id"));
					new AreaDAO().updateName(id, newName);
				} catch(Exception ex) {
					session.setAttribute("upd_area", false);
				}
			} else session.setAttribute("upd_area", false);
			response.sendRedirect("manage_area.jsp");
		
		} else if(request.getParameter("submit").equals("Update Checkpost")) {
			HttpSession session = request.getSession();
			session.setAttribute("upd_chkp", true);
			String newName = request.getParameter("subarea_name");
			if(newName != null && !newName.equals("")) {
				try {
					int id = Integer.parseInt((String) session.getAttribute("subarea_id"));
					new SubAreaDAO().updateName(id, newName);
				} catch(Exception ex) {
					session.setAttribute("upd_chkp", false);
				}
			} else session.setAttribute("upd_chkp", false);
			response.sendRedirect("manage_checkpost.jsp");
		
		} else if(request.getParameter("submit").equals("Update Complaint")) {
			HttpSession session = request.getSession();
			session.setAttribute("upd_comp", true);
			String ack = request.getParameter("status");
			String res = request.getParameter("response");
			if(res != null && !res.equals("")) {
				try {
					int id = Integer.parseInt((String) session.getAttribute("paramid"));
					ComplaintDAO dao = new ComplaintDAO();
					Complaint oldComplaint = dao.getComplaintById(id);
					oldComplaint.setAcknowledged(ack != null);
					oldComplaint.setResponse(res);
					dao.update(oldComplaint);
				} catch(Exception ex) {
					session.setAttribute("upd_comp", false);
				}
			} else session.setAttribute("upd_comp", false);
			response.sendRedirect("manage_complaint.jsp");
		
		} else if(request.getParameter("submit").equals("Update Rule")) {
			HttpSession session = request.getSession();
			session.setAttribute("rule_update_success", true);
			
			String ruleName = request.getParameter("rule_name");
			String ruleDesc = request.getParameter("rule_desc");
			if(ruleName != null && !ruleName.equals("") && ruleDesc != null && !ruleDesc.equals("")) {
				try {
					int fine = Integer.parseInt(request.getParameter("rule_fine"));
					int catId = Integer.parseInt(request.getParameter("cat_name"));
					int targetRuleId = Integer.parseInt((String) session.getAttribute("target_id")); 
					
					RuleDAO dao = new RuleDAO();
					CatagoryDAO catDAO = new CatagoryDAO();
					Rule newRule = dao.getRuleById(targetRuleId);
					newRule.setFine(fine);
					newRule.setRuleDesc(ruleDesc);
					newRule.setRuleName(ruleName);
					newRule.setCat(catDAO.getCatagoryById(catId));
					dao.update(newRule);
				} catch(Exception ex) {
					ex.printStackTrace();
					session.setAttribute("rule_update_success", false);
				}
			} else session.setAttribute("rule_update_success", false);
			response.sendRedirect("manage_rule.jsp");
			
			
		} else if(request.getParameter("submit").equals("Insert Rule")) {
			HttpSession session = request.getSession();
			String ruleName = request.getParameter("rule_name");
			int ruleId = Integer.parseInt(request.getParameter("rule_id"));
			int fine = Integer.parseInt(request.getParameter("fine"));
			String ruleDesc = request.getParameter("rule_desc");
			int catId = Integer.parseInt(request.getParameter("cat_name"));
			Catagory cat = new CatagoryDAO().getCatagoryById(catId);
			Rule rule = new Rule(ruleName, ruleDesc, ruleId, fine);
			rule.setCat(cat);
			cat.getRule().add(rule);
			RuleDAO dao = new RuleDAO();
			dao.insert(rule);
			session.setAttribute("success", true);
			response.sendRedirect("add_rule.jsp");
			
			
		} else if(request.getParameter("submit").equals("Add Category")) {
			HttpSession session = request.getSession();
			String catName = request.getParameter("cat_name");
			String catDesc = request.getParameter("cat_desc");
			Catagory cat = new Catagory(catName, catDesc);
			CatagoryDAO dao = new CatagoryDAO();
			dao.insert(cat);
			session.setAttribute("success", true);
			response.sendRedirect("add_catagory.jsp");
			
		} else if(request.getParameter("submit").equals("Update Category")) {
			HttpSession session = request.getSession();
			String name = request.getParameter("cat_name");
			String desc = request.getParameter("cat_desc");
			int id = Integer.parseInt((String) session.getAttribute("cat_id"));
			CatagoryDAO dao = new CatagoryDAO();
			Catagory cat = dao.getCatagoryById(id);
			cat.setCatName(name);
			cat.setCatDesc(desc);
			dao.update(cat);
			session.setAttribute("update_cat_success", true);
			response.sendRedirect("manage_catagory.jsp");
			
		} else if(request.getParameter("submit").equals("Search License")) {
			HttpSession session = request.getSession();
			String licenseNo = request.getParameter("license_no");
			if(!licenseNo.equals("")) {
				// User has inserted license no so search for it
				LicenseDAO lDAO = new LicenseDAO();
				License holder = lDAO.getLicenseByNo(licenseNo);
				if(holder == null) {
					// User didn't enter correct license no
					session.setAttribute("wrongInput", true);
					response.sendRedirect("generate_challan_get_license_no.jsp");
					return;
				} else {
					// We got license no from user which is valid so just send to generation
					response.sendRedirect("generate_challan.jsp?licenseno=" + licenseNo);
				}
			} else {
				// We need to find license number on our own :P
				String fname = request.getParameter("first_name");
				String lname = request.getParameter("last_name");
				String mname = request.getParameter("middle_name");
				String date = request.getParameter("date");
				String month = request.getParameter("month");
				String year = request.getParameter("year");
				int pcode = Integer.parseInt(request.getParameter("pincode"));
				String bGroup = request.getParameter("blood_group");
				List<String> lno = new LicenseDAO().getLicenseNo(fname, lname, mname, pcode, bGroup, month, date, year);
				if(lno == null || lno.size() == 0) {
					// We couldn't find license in database
					session.setAttribute("noMatch", true);
					response.sendRedirect("generate_challan_get_license_no.jsp");
					return;
				}
				// We found user's license no, so navigate to challan generation
				session.setAttribute("license_no", lno);
				response.sendRedirect("generate_challan_view_result.jsp");
			}
		} else if(request.getParameter("submit").equals("Update Settings")) {
			HttpSession session = request.getSession();
			String maxChallan = request.getParameter(Common.PREF_MAX_CHALLAN_PER_DAY);
			String maxComp = request.getParameter(Common.PREF_MAX_COMPLAINT_PER_DAY);
			session.setAttribute("pref_update_success", true);
			if(maxChallan != null && maxComp != null) {
				try {
					// Check if entered string is valid number
					Integer.parseInt(maxChallan);
					Integer.parseInt(maxComp);
					
					PreferenceManager prefManager = new PreferenceManager();
					Preference prefMxChallan = prefManager.getPreference(Common.PREF_MAX_CHALLAN_PER_DAY);
					Preference prefMxComp = prefManager.getPreference(Common.PREF_MAX_COMPLAINT_PER_DAY);
					prefMxChallan.setValue(maxChallan);
					prefMxComp.setValue(maxComp);
					prefManager.update(prefMxComp);
					prefManager.update(prefMxChallan);
				} catch(NumberFormatException ex) {
					session.setAttribute("pref_update_success", false);
				}
			}
			response.sendRedirect("system_setting.jsp");
		} else if(request.getParameter("submit").equals("Change Password")){
			HttpSession session = request.getSession();
			String newPass = request.getParameter("new_pass");
			String cPass = request.getParameter("c_pass");
			if(newPass.equals(cPass)  && newPass!=null && !newPass.equals("")&& cPass!=null && !cPass.equals("")){
				User user = (User) session.getAttribute("user_info");
				String uid = user.getUserID();
				new UserDAO().updatePass(uid, newPass);
				response.sendRedirect("profile.jsp");
				
			}else{
				session.setAttribute("wrong_pass", true);
				response.sendRedirect("change_pass.jsp");
			}
		} else if(request.getParameter("submit").equals("Edit Profile")){
			HttpSession session = request.getSession();
			User vo = (User)session.getAttribute("user_info");
			String oldid = vo.getUserID();
			int id = vo.getUserDetail().getUserID_pkey();
			String fname = request.getParameter("first_name");
			String lname = request.getParameter("last_name");
			String mobileNo = request.getParameter("mobile_no");
			String street = request.getParameter("street");
			String state = request.getParameter("state");
			String city = request.getParameter("city");
			String email = request.getParameter("email");
			int pincode = Integer.parseInt(request.getParameter("pincode"));
			UserDetail ud = new UserDetailDAO().getUserDetailById(id);
			ud.setFirstName(fname);
			ud.setLastName(lname);
			ud.setMobileNo(mobileNo);
			ud.setStreet(street);
			ud.setState(state);
			ud.setCity(city);
			ud.setPincode(pincode);
			new UserDetailDAO().update(ud);
			new UserDAO().updateuid(oldid, email);
			response.sendRedirect("index.jsp?logout=1.jsp");
			
		}else if(request.getParameter("submit").equals("Search For Challan")) {
			HttpSession session = request.getSession();
			String[] name = request.getParameterValues("rule_drop");
			String licenseNo = request.getParameter("license_no");
			String vehicleNo = request.getParameter("vehicle_no");
			boolean issuspend = request.getParameter("status")== null ? false : true;
			User user = (User) session.getAttribute("user_info");
			String redir = "view_challan.jsp";
			if(licenseNo == null || vehicleNo == null || user == null) {
				session.setAttribute("error", true);
				redir = "generate_challan.jsp";
			}
			RuleDAO rudao = new RuleDAO();
			HashSet<Rule> rules = new HashSet<Rule>();
			Challan challan = new Challan();
			for(int i = 0; i < name.length; i++) {
				rules.add(rudao.getRuleById(Integer.parseInt(name[i])));
			}
			challan.setRule(rules);
			challan.setLicenseNo(licenseNo);
			challan.setVehicleNo(vehicleNo);
			challan.setIssuspend(issuspend);
			
			challan.setPolice(user);
			challan.setTimestamp(new Date());
			Integer x = new ChallanDAO().insert(challan);
			
			session.setAttribute("chaallan", x);
			session.setAttribute("holder", licenseNo);
			response.sendRedirect(redir);
		}	
	}
	@SuppressWarnings({ "unused", "deprecation" })
	private boolean isSameDate(Date d1, Date d2) {
		if(d1.getYear() == d2.getYear() && d1.getMonth() == d2.getMonth() && d1.getDate() == d2.getDate())
			return true;
		return false;
	}

}
