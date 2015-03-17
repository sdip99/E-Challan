package org.echallan.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.echallan.Common;
import org.echallan.dataAccessObject.AreaDAO;
import org.echallan.dataAccessObject.CatagoryDAO;
import org.echallan.dataAccessObject.CityDAO;
import org.echallan.dataAccessObject.ComplaintDAO;
import org.echallan.dataAccessObject.RuleDAO;
import org.echallan.dataAccessObject.SubAreaDAO;
import org.echallan.dataAccessObject.UserDAO;
import org.echallan.dataAccessObject.UserDetailDAO;
import org.echallan.valueObject.Area;
import org.echallan.valueObject.Catagory;
import org.echallan.valueObject.City;


import org.echallan.valueObject.Complaint;
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
		// TODO Auto-generated method stub
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
			String fname = request.getParameter("first_name");
			String lname = request.getParameter("last_name");
			String mobileNo = request.getParameter("mobile_no");
			String street = request.getParameter("street");
			String state = request.getParameter("state");
			String city = request.getParameter("city");
			String email = request.getParameter("email");
			String pass = request.getParameter("password");
			int pincode = Integer.parseInt(request.getParameter("pincode"));
			int subAreaAssign = Integer.parseInt(request.getParameter("subarea_assigned"));
			UserDetail userDetail = new UserDetail(fname, lname, subAreaAssign, mobileNo, street, city, state, pincode);
			User user = new User(email, pass, 0);
			user.setUserDetail(userDetail);
			userDetail.setUser(user);
			UserDAO dao = new UserDAO();
			dao.insert(user);
			session.setAttribute("success", true);
			response.sendRedirect("add_officer.jsp");
		
		} else if(request.getParameter("submit").equals("Insert City")) {
			HttpSession session = request.getSession();
			String name = request.getParameter("city_name");
			City city = new City(name);
			CityDAO dao = new CityDAO();
			dao.insert(city);
			session.setAttribute("success", true);
			response.sendRedirect("insert_city.jsp");
		
		} else if(request.getParameter("submit").equals("Insert Area")) {
			HttpSession session = request.getSession();
			String name = request.getParameter("area_name");
			int cityID = Integer.parseInt(request.getParameter("subarea_drop"));
			City city = new CityDAO().getCityById(cityID);
			Area area = new Area();
			area.setName(name);
			area.setCity(city);
			city.getArea().add(area);
			new AreaDAO().insert(area);
			session.setAttribute("success", true);
			response.sendRedirect("insert_area.jsp");
		
		} else if(request.getParameter("submit").equals("Insert CheckPost")) {
			HttpSession session = request.getSession();
			String name = request.getParameter("subarea_name");
			int areaID = Integer.parseInt(request.getParameter("area_drop"));
			Area area = new AreaDAO().getAreaById(areaID);
			SubArea subArea = new SubArea();
			subArea.setName(name);
			subArea.setArea(area);
			SubAreaDAO dao = new SubAreaDAO();
			dao.insert(subArea);
			session.setAttribute("success", true);
			response.sendRedirect("insert_checkpost.jsp");
		
		} else if(request.getParameter("submit").equals("Update City")) {
			HttpSession session = request.getSession();
			String name = request.getParameter("city_name");
			int id = Integer.parseInt((String) session.getAttribute("city_id"));
			session.setAttribute("success", true);
			new CityDAO().updateCity(id, name);
			response.sendRedirect("update_city.jsp");
		
		} else if(request.getParameter("submit").equals("Update Officer")) {
			HttpSession session = request.getSession();
			String uid = (String) session.getAttribute("uid");
			String fname = request.getParameter("first_name");
			String lname = request.getParameter("last_name");
			String mobileNo = request.getParameter("mobile_no");
			String street = request.getParameter("street");
			String state = request.getParameter("state");
			String city = request.getParameter("city");
			String email = request.getParameter("email");
			String pass = request.getParameter("password");
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
			session.setAttribute("success", true);
			// TODO: Redirect back to same page
			response.sendRedirect("manage_officer.jsp");
		
		} else if(request.getParameter("submit").equals("Update Area")) {
			HttpSession session = request.getSession();
			String newName = request.getParameter("area_name");
			int id = Integer.parseInt((String) session.getAttribute("area_id"));
			session.setAttribute("success", true);
			new AreaDAO().updateName(id, newName);
			response.sendRedirect("update_area.jsp");
		
		} else if(request.getParameter("submit").equals("Update Checkpost")) {
			HttpSession session = request.getSession();
			String newName = request.getParameter("subarea_name");
			int id = Integer.parseInt((String) session.getAttribute("subarea_id"));
			session.setAttribute("success", true);
			new SubAreaDAO().updateName(id, newName);
			response.sendRedirect("update_checkpost.jsp");
		
		} else if(request.getParameter("submit").equals("Update Complaint")) {
			HttpSession session = request.getSession();
			String ack = request.getParameter("status");
			String res = request.getParameter("response");
			int id = Integer.parseInt((String) session.getAttribute("paramid"));
			ComplaintDAO dao = new ComplaintDAO();
			Complaint oldComplaint = dao.getComplaintById(id);
			oldComplaint.setAcknowledged(ack != null);
			oldComplaint.setResponse(res);
			dao.update(oldComplaint);
			session.setAttribute("success", true);
			response.sendRedirect("manage_complaint.jsp");
		
		} else if(request.getParameter("submit").equals("Update Rule")) {
			HttpSession session = request.getSession();
			String ruleName = request.getParameter("rule_name");
			int ruleId = Integer.parseInt(request.getParameter("rule_id"));
			int fine = Integer.parseInt(request.getParameter("fine"));
			String ruleDesc = request.getParameter("rule_desc");
			int catId = Integer.parseInt(request.getParameter("cat_name"));
			
			
			RuleDAO dao = new RuleDAO();
			dao.updateRule(catId, ruleName, ruleDesc, ruleId, fine);
			session.setAttribute("success", true);
			response.sendRedirect("add_rule.jsp");
			
			
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
				session.setAttribute("success", true);
				CatagoryDAO dao = new CatagoryDAO();
				dao.updateCatagory(id, name, desc);
				response.sendRedirect("update_catagory.jsp");
			
			}
	}

}
